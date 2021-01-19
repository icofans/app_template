import 'dart:async';

import 'package:app_template/base/net/error_handle.dart';
import 'package:app_template/base/util/sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

enum PageStatus {
  idle, // 空闲状态
  loading, // 加载中
  empty, // 无数据
  error, // 加载失败
}

enum PageStatusError {
  defaultError,
  networkTimeOutError, //网络错误
  unauthorizedError //未授权(一般为未登录)
}

/// BaseProvide
class BaseModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  // api
  // final Api api = Api.instance;
  // sp
  final Sp sp = Sp.instance;

  // 页面加载状态
  PageStatus pageStatus = PageStatus.idle;

  bool get isLoading => pageStatus == PageStatus.loading;
  bool get isIdle => pageStatus == PageStatus.idle;
  bool get isEmpty => pageStatus == PageStatus.empty;
  bool get isError => pageStatus == PageStatus.error;

  void setIdle() {
    pageStatus = PageStatus.idle;
  }

  void setLoading() {
    pageStatus = PageStatus.loading;
  }

  void setEmpty() {
    pageStatus = PageStatus.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, {String message}) {
    PageStatusError errorType = PageStatusError.defaultError;
    if (e is RequestError) {
      if (e.code == ErrorHandle.net_error) {
        errorType = PageStatusError.networkTimeOutError;
      }
    }

    onError(errorType);
    pageStatus = PageStatus.error;
  }

  void onError(PageStatusError errorType) {}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('[dispose] -->$runtimeType');
    super.dispose();
  }
}

// List
abstract class ListModel extends BaseModel {
  // 分页相关
  int pageNo = 0;
  static const int pageSize = 20;

  // 页面数据count
  int count = 0;

  // 上拉加载是否可用
  bool get loadEnabled => count > datas.length;

  List datas = [];

  EasyRefreshController _refreshController = EasyRefreshController();
  EasyRefreshController get refreshController => _refreshController;

  /// 初始化页面数据
  initData() {
    setLoading();
    onRefresh(isFirst: true);
  }

  // 下拉刷新
  Future onRefresh({bool isFirst = false}) {
    Completer completer = Completer();
    loadData().listen((event) {
      _refreshController.finishRefresh();
      if (datas.isEmpty) {
        _refreshController.resetLoadState();
        setEmpty();
      } else {
        if (count == datas.length) {
          _refreshController.finishLoad(noMore: true);
        } else {
          _refreshController.resetLoadState();
        }
        setIdle();
      }
      notifyListeners();
    }, onError: (e) {
      _refreshController.finishRefresh();
      setError(e);
      if (isFirst) {
        datas.clear();
      }
      notifyListeners();
    }, onDone: () {
      // 本来想通过 loadData().listen((event) {}).asFuture() 进行转换,但是会抛出错误,
      // completer.completeError(e);
      completer.complete();
    });
    return completer.future;
  }

  Future onLoad() {
    Completer completer = Completer();
    loadMore().listen((data) {
      if (data.isEmpty) {
        pageNo--;
        _refreshController.finishLoad(noMore: true);
      } else {
        notifyListeners();
        _refreshController.finishLoad(noMore: count == datas.length);
      }
    }, onError: (e) {
      pageNo--;
      _refreshController.resetLoadState();
      _refreshController.finishLoad();
    }, onDone: () {
      completer.complete();
    });
    return completer.future;
  }

  Stream loadData();

  Stream loadMore();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}

abstract class SingleModel extends BaseModel {
  initData() {
    setLoading();
    fetchData(fetch: true);
  }

  // 加载数据
  void fetchData({bool fetch = false, void Function() onDone}) {
    loadData().listen((data) {
      if (data == null) {
        setEmpty();
      } else {
        setIdle();
        notifyListeners();
      }
    }, onError: (e) {
      setError(e);
      if (fetch) {
        notifyListeners();
      }
    }, onDone: () {
      onDone?.call();
    });
  }

  Stream loadData();
}
