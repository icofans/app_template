import 'dart:async';

import 'package:app_template/base/view_model/base_model.dart';

class SpModel extends SingleModel {
  String buttonText = "加载框";
  @override
  Stream loadData() {
    return Stream.empty();
  }

  String savaStr = "未操作";
  String str = "未操作";

  void saveData() {
    sp.setString("test", "哈哈");
    savaStr = "哈哈";
    notifyListeners();
  }

  void getData() {
    String data = sp.getString("test");
    str = data ?? str;
    notifyListeners();
  }
}
