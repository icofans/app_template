import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String kNetPortKey = 'kNetPortKey';

const String kNetAvailable = 'kNetAvailable';
const String kNetEnable = 'kEnable', kNetDisable = 'kDisable';

void observerNetState(SendPort sendPort) {
  final String china = 'baidu.com';
  final String usa = 'google.com';
  final ReceivePort receivePort = ReceivePort();
  receivePort.listen((message) {
    debugPrint('$kNetPortKey  : $message');
  });

  sendPort.send([kNetPortKey, receivePort.sendPort]);

  final timer = Timer.periodic(Duration(seconds: 10), (timer) async {
    try {
      ///注意区分国内外，或者用你自己的
      String host = china;
      final result = await InternetAddress.lookup(host);
      debugPrint('$kNetPortKey  $result');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        ///net enable
        sendPort.send([kNetAvailable, kNetEnable]);
      } else {
        sendPort.send([kNetAvailable, kNetDisable]);
      }
    } on SocketException catch (_) {
      sendPort.send([kNetAvailable, kNetDisable]);
    }
  });
}
