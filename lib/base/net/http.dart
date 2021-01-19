import 'dart:async';
import 'dart:convert';

import 'package:app_template/base/config/config.dart';
import 'package:app_template/base/net/base_entity.dart';
import 'package:app_template/base/net/error_handle.dart';
import 'package:app_template/base/util/sp.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';

typedef SuccessCallback = void Function(dynamic json);
typedef ErrorCallback = void Function(int code, String reason);
typedef CompletionCallback = void Function();

enum Method { get, post, put, patch, delete, head }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/// 网络请求
final _dio = Dio()
  ..transformer = DefaultTransformer(jsonDecodeCallback: parseJson)
  ..options = BaseOptions(
    baseUrl: Config.instance.baseUrl,
    connectTimeout: Config.instance.connectTimeout,
    receiveTimeout: Config.instance.receiveTimeout,
    responseType: ResponseType.json,
  )
  ..interceptors.add(CookieManager(CookieJar()))
  ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
  ..interceptors.add(
    InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError e) async {
      print("进入拦截器");
      var response = e.response?.data;
      int code = 0;
      if (response != null && response is Map && response.containsKey("code")) {
        code = response["code"];
      }
      // 登陆失效
      if (response != null && code == 1021) {
        print(e.response);
        bool result = await _refreshCookie();
        if (result) {
          // 重新请求失败接口
          var request = e.response.request;
          try {
            print("----------- 重新请求接口 ------------");
            var response = await _dio.request(request.path,
                data: request.data,
                queryParameters: request.queryParameters,
                cancelToken: request.cancelToken,
                options: request,
                onReceiveProgress: request.onReceiveProgress);
            return response;
          } on DioError catch (e) {
            return e;
          }
        }
      }
      return e;
    }),
  );

///获取新Cookie
Future<bool> _refreshCookie() async {
  Sp sp = Sp.instance;
  String account = sp.getString("account");
  String password = sp.getString("password");
  if (account.isNotEmpty && password.isNotEmpty) {
    var params = {
      "passport": account,
      "password": password,
    };
    try {
      var response = await _request(Method.post.value, "/user/signIn/session",
          data: params);
      return response != null ? true : false;
    } catch (e) {
      return false;
    }
  }
  return false;
}

// 请求处理
Future _request(
  String method,
  String url, {
  dynamic data,
  Map<String, dynamic> queryParameters,
  CancelToken cancelToken,
  Options options,
  String baseUrl,
  void Function(int count, int total) onReceiveProgress,
}) {
  Completer completer = new Completer();
  if (baseUrl != null) {
    _dio.options.baseUrl = baseUrl;
  } else {
    _dio.options.baseUrl = Config.instance.baseUrl;
  }
  _dio
      .request(
    url,
    data: data,
    queryParameters: queryParameters,
    options: _checkOptions(method, options),
    cancelToken: cancelToken,
    onReceiveProgress: onReceiveProgress,
  )
      .then((response) {
    try {
      final data = response?.data;
      BaseEntity result = BaseEntity.fromJson(data);
      if (result.success) {
        completer.complete(data);
      } else {
        print("code = ${result.code},message=${result.message}");
        completer
            .completeError(RequestError(result.code, result.message ?? "未知错误"));
      }
    } catch (e) {
      BaseEntity result = BaseEntity(ErrorHandle.parse_error, '数据解析错误！', null);
      completer
          .completeError(RequestError(result.code, result.message ?? "未知错误"));
    }
  }, onError: (dynamic e) {
    RequestError error;
    if (e.response != null) {
      var response = e.response.data;
      int code = 999;
      String msg = "未知错误";
      try {
        code = response["code"];
        msg = response["message"] ?? "未知错误";
      } catch (e) {}
      error = RequestError(code, msg);
    } else {
      error = ErrorHandle.handleException(e);
    }
    completer.completeError(error);
  });

  return completer.future;
}

Options _checkOptions(String method, Options options) {
  options ??= Options();
  options.method = method;
  return options;
}

/// 网络请求-get
///
Stream get(
  String url, {
  Map<String, dynamic> params,
  String baseUrl,
  void Function(int count, int total) onReceiveProgress,
}) {
  return Stream.fromFuture(_request(
    Method.get.value,
    url,
    data: params,
    baseUrl: baseUrl,
    onReceiveProgress: onReceiveProgress,
  )).asBroadcastStream();
}

/// 网络请求-post
///
Stream post(String url, {Map<String, dynamic> params}) {
  return Stream.fromFuture(_request(
    Method.post.value,
    url,
    data: params,
  )).asBroadcastStream();
}

/// 网络请求-put
///
Stream put(String url, {Map<String, dynamic> params}) {
  return Stream.fromFuture(_request(
    Method.put.value,
    url,
    data: params,
  )).asBroadcastStream();
}

/// 网络请求-put
///
Stream delete(String url, {Map<String, dynamic> params}) {
  return Stream.fromFuture(_request(
    Method.delete.value,
    url,
    data: params,
  )).asBroadcastStream();
}
