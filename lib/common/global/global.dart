import 'package:app_template/base/util/util.dart';

class Global {
  factory Global() => _getInstance();
  static Global get instance => _getInstance();
  static Global _instance;

  static Global _getInstance() {
    if (_instance == null) {
      _instance = new Global._internal();
    }
    return _instance;
  }

  Global._internal() {
    var sp = Sp.instance;
    this.isLogin = sp.getBool("isLogin") ?? false;
    this.username = sp.getString("username");
    this.password = sp.getString("password");
  }

  // 登录相关数据
  bool isLogin = false;
  String username;
  String password;

  void onLogin({String username, String password}) {
    var sp = Sp.instance;
    sp.setString("username", username);
    sp.setString("password", password);
    sp.setBool("isLogin", true);
    this.username = username;
    this.password = password;
    this.isLogin = isLogin;
  }

  // ip国外标识
  void setIsForeign(bool isForeign) {
    var sp = Sp.instance;
    sp.setBool("isForeign", isForeign);
  }

  // 用户数据
  Map userdata;

  // userId
  String get userId {
    if (userdata != null) {
      return userdata["id"];
    } else {
      return null;
    }
  }
}
