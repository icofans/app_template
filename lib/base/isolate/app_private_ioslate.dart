import 'dart:isolate';

import 'package:app_template/base/isolate/observe/app_status.dart';
import 'package:app_template/base/isolate/observe/net_observer.dart';
import 'package:app_template/base/util/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

///app 状态监测类，负责各种状态监测
///多数监测工作在子isolate
class AppPrivateIsolate {
  final AppStatus appStatus = AppStatus();

  ///
  static AppPrivateIsolate _appPrivateIsolate;

  factory AppPrivateIsolate() => getInstance();

  static AppPrivateIsolate getInstance() {
    if (_appPrivateIsolate == null) {
      _appPrivateIsolate = AppPrivateIsolate._();
    }
    return _appPrivateIsolate;
  }

  AppPrivateIsolate._();

  final ReceivePort _netReceivePort = ReceivePort();
  SendPort _netSendPort;
  Isolate _netIsolate;

  ///监测网络状态和连接类型
  void initNetObserver() async {
    if (_netIsolate != null) return;
    _netIsolate =
        await Isolate.spawn(observerNetState, _netReceivePort.sendPort);

    /// message<String,dynamic>
    _netReceivePort.listen((message) {
      debugPrint('$message');
      String key = message[0];
      var value = message[1];
      if (key == kNetPortKey) {
        _netSendPort = value;
        debugPrint(_netSendPort.toString());
      } else if (key == kNetAvailable) {
        ///网络是否可用
        debugPrint('${message[1]}');
        String available = message[1];

        ///可以根据状态做对应的操作 具体看业务需求
        if (available == kNetDisable) {
          Toast.show(msg: "网络不可用");
          //cancelAllRequest();
          appStatus.setNetStatus(NetStatus.Disable);
        } else if (available == kNetEnable) {
          debugPrint('网络正常');
          appStatus.setNetStatus(NetStatus.Enable);
        }
      }
    });

    ///网络连接方式的监听
    ///   ！ 注意这个不要放在child isolate
    Connectivity().onConnectivityChanged.listen((netType) {
      debugPrint('$netType');
      if (netType == ConnectivityResult.wifi) {
        appStatus.setNetType(NetType.wifi);
      } else if (netType == ConnectivityResult.mobile) {
        appStatus.setNetType(NetType.mobile);
      } else if (netType == ConnectivityResult.none) {
        appStatus.setNetType(NetType.none);
      }
    });
  }
}
