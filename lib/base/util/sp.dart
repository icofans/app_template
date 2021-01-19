import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// 用来做shared_preferences的存储
class Sp {
  static Sp _instance;
  static Sp get instance {
    if (_instance == null) {
      _instance = new Sp._();
    }
    return _instance;
  }

  static SharedPreferences _spf;

  Sp._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  // 需要初始化
  Future initialize() async {
    await _instance._init();
  }

  static bool _beforCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforCheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> setString(String key, String value) {
    if (_beforCheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforCheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> setBool(String key, bool value) {
    if (_beforCheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforCheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> setInt(String key, int value) {
    if (_beforCheck()) return null;
    return _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforCheck()) return null;
    return _spf.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) {
    if (_beforCheck()) return null;
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  Future<bool> setStringList(String key, List<String> value) {
    if (_beforCheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforCheck()) return null;
    return _spf.clear();
  }
}
