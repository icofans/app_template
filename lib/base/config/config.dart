import 'dart:convert';

import 'package:app_template/base/config/config.constant.dart';
import 'package:app_template/base/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

export 'config.constant.dart';
export 'config.route.dart';

enum Environment {
  dev,
  testing,
  production,
}

/// {"name": "简体中文", "languageCode": "zh", "countryCode": "CN" }

class Config {
  factory Config() => _getInstance();
  static Config get instance => _getInstance();
  static Config _instance;

  static Config _getInstance() {
    if (_instance == null) {
      _instance = new Config._internal();
    }
    return _instance;
  }

  Config._internal() {
    // init
  }

  Future<void> initialize() async {
    // sp
    await Sp.instance.initialize();
    // 屏幕适配
    Adapt.initialize(designWidth: 375, designHeight: 667);
    // provider
    Provider.debugCheckInvalidValueType = null;
  }

  void configDesignInfo({double designWidth, double designHeight}) {
    Adapt.initialize(designWidth: designWidth, designHeight: designHeight);
  }

  /// 配置接口环境
  ///
  /// 当前运行环境
  Environment env = Environment.dev;
  void configEnv(Environment environment) {
    env = environment;
  }

  /// 配置http地址
  ///
  ///
  void configBaseUrl({
    @required String dev,
    @required String testing,
    @required String production,
  }) {
    _devBaseUrl = dev;
    _testingBaseUrl = testing;
    _productionBaseUrl = production;
  }

  /// 配置支持的语言
  ///
  /// {"name": "简体中文", "languageCode": "zh", "countryCode": "CN" }
  void configSupportedLocales(List supportedLocales) {
    debugPrint(supportedLocales.toString());
    if (supportedLocales.isEmpty) return;
    Sp sp = Sp.instance;
    sp.setString(supportLocalizationsKey, jsonEncode(supportedLocales));
  }

  /// 配置支持的语言
  ///
  /// {"name": "简体中文", "languageCode": "zh", "countryCode": "CN" }
  void configTheme({
    @required Color primaryColor,
    @required Color accentColor,
  }) {
    primaryColor = primaryColor;
    accentColor = accentColor;
  }

  Color primaryColor;
  Color accentColor;

  /// 配置屏幕方向
  ///
  ///
  void configPreferredOrientations(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  /// 状态栏沉浸式
  ///
  ///
  void configStatusBarImmerse() {
    // 状态栏
    if (Package.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  /// 环境地址
  ///
  /// 配置环境地址
  String _devBaseUrl = "";
  String _testingBaseUrl = "";
  String _productionBaseUrl = "";

  /// 连接服务器超时时间，单位是毫秒.
  int connectTimeout = 10000;

  /// 接收数据的最长时限，单位是毫秒.
  int receiveTimeout = 8000;

  /// 是否为release模式运行
  ///
  /// isRelease
  bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// 网络请求配置
  ///
  /// baseUrl
  get baseUrl {
    if (env == Environment.dev) {
      return _devBaseUrl;
    }
    if (env == Environment.testing) {
      return _testingBaseUrl;
    }
    if (env == Environment.production) {
      return _productionBaseUrl;
    }
  }
}
