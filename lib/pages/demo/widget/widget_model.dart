import 'dart:async';

import 'package:app_template/common/api/api.dart';
import 'package:app_template/base/net/error_handle.dart';
import 'package:app_template/base/view_model/base_model.dart';

class WidgetModel extends ListModel {
  Api api = Api.instance;

  bool failData = true;
  @override
  Stream loadData() {
    pageNo = 1;
    // return api.login(passport: "wanghao", password: "1234567").map((event) {});
    return Stream.fromFuture(_mockData(pageNo)).map((event) {
      datas = event;
      return datas;
    });
  }

  @override
  Stream loadMore() {
    pageNo++;
    return Stream.fromFuture(_mockData(pageNo)).map((event) {
      // 这里可以对数据重新处理
      datas = event;
      return datas;
    });
  }

  void resetData() {
    datas = [];
    setEmpty();
    notifyListeners();
  }

  Future _mockData(int pageNo) {
    Completer completer = Completer();
    Future.delayed(Duration(seconds: 3)).then((value) {
      List data = [];
      count = 100;
      if (pageNo == 1) {
        data = List.generate(20, (index) => index);
      } else {
        data = datas;
        data.addAll(List.generate(20, (index) => index));
      }
      // Future.error(error)
      // completer.complete(data);
      if (failData) {
        completer.completeError(RequestError(10, "温柔"));
      } else {
        completer.complete(data);
      }
    });
    return completer.future;
  }
}
