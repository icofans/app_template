import 'package:flutter/material.dart';

/// 定义了网络请求的接口
///
///
abstract class Interface {
  // 登录
  Stream login({
    @required String passport,
    @required String password,
  });

  // 登出
  Stream logout();
}
