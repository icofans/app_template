import 'package:app_template/base/net/http.dart';
import 'package:app_template/common/api/interface.dart';

class Api implements Interface {
  factory Api() => _getInstance();
  static Api get instance => _getInstance();
  static Api _instance;

  static Api _getInstance() {
    if (_instance == null) {
      _instance = new Api._internal();
    }
    return _instance;
  }

  Api._internal() {
    // init method
  }

  @override
  Stream login({
    String passport,
    String password,
  }) {
    assert(passport != null, "账号不能为空");
    assert(password != null, "密码不能为空");
    var params = {
      "username": passport,
      "password": password,
    };
    return post("/common/signIn/", params: params);
  }

  @override
  Stream logout() {
    return put("/user/signOut");
  }
}
