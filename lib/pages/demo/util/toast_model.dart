import 'dart:async';

import 'package:app_template/base/view_model/base_model.dart';

class ToastModel extends SingleModel {
  String buttonText = "加载框";
  @override
  Stream loadData() {
    return Stream.fromFuture(_mockData()).map((event) {
      buttonText = "家在完成";
      return "修改了数据";
    });
  }

  Future _mockData() {
    Completer completer = Completer();
    Future.delayed(Duration(seconds: 3)).then((value) {
      completer.complete("加载完成");
    });
    return completer.future;
  }
}
