import 'dart:convert';

import 'package:app_template/base/config/config.constant.dart';
import 'package:app_template/base/util/sp.dart';
import 'package:flutter/material.dart';

///有些手机 简体中文是 zh_Hans_CN 繁体是 zh_Hant_TW
///有些手机 中文简体是 zh_CN 繁体是 zh_TW
///台湾标识建议使用tw-CH，zh_TW可能引起问题
//static const localeValueList = ['', 'zh-CH', 'en-US',"tw-CH"];

class AppLocaleModel extends ChangeNotifier {
  final Sp sp = Sp.instance;

  // 支持的语言列表
  List get supportLocalizations {
    var data = sp.getString(supportLocalizationsKey);
    return jsonDecode(data);
  }

  // 切换语言
  // 设置为null时,为跟随系统
  void changeLocale(int index) {
    if (currentLocaleIndex == index) return;
    if (index == null) {
      sp.remove(currentLocaleIndexKey);
    } else {
      sp.setInt(currentLocaleIndexKey, index);
    }
    notifyListeners();
  }

  // 当前语言名字
  // 为null时表示跟随系统
  String get currentLanguageName {
    int index = sp.getInt(currentLocaleIndexKey);
    if (index != null) {
      Map item = supportLocalizations[index];
      return item[languageName];
    } else {
      return null;
    }
  }

  // 当前语言索引
  // 为null时表示跟随系统
  int get currentLocaleIndex {
    int index = sp.getInt(currentLocaleIndexKey);
    if (index != null) {
      return index;
    } else {
      return null;
    }
  }

  // 获取locale 未切换时默认为跟随系统
  Locale getLocale() {
    int index = sp.getInt(currentLocaleIndexKey);
    if (index != null) {
      Map item = supportLocalizations[index];
      debugPrint("切换语言为: ${item[languageCode]} ${item[countryCode]}");
      return Locale(item[languageCode], item[countryCode]);
    } else {
      debugPrint("跟随系统语言");
      return null;
    }
  }
}
