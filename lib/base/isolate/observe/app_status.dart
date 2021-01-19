enum NetStatus { Enable, Disable }

enum NetType { wifi, mobile, none }

class AppStatus {
  static AppStatus _singleton;
  factory AppStatus() => _getInstance();
  static AppStatus _getInstance() {
    if (_singleton == null) {
      _singleton = AppStatus._();
    }
    return _singleton;
  }

  AppStatus._();

  ///网络是否可用
  NetStatus netStatus = NetStatus.Enable;
  setNetStatus(NetStatus status) {
    netStatus = status;
  }

  ///网络连接方式
  NetType netType;
  setNetType(NetType type) {
    netType = type;
  }
}
