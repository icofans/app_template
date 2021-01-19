import 'package:app_template/pages/demo/isolate/isolate_page.dart';
import 'package:app_template/pages/demo/setting/setting_page.dart.dart';
import 'package:app_template/pages/demo/widget/widget_page.dart';
import 'package:app_template/pages/demo/util/util_page.dart';
import 'package:flutter/material.dart';

mixin DRoutes {
  static final util = "/toast";
  static final widget = "/widget";
  static final setting = "/setting";
  static final isolate = "/isolate";

  static final dRoutes = <String, WidgetBuilder>{
    util: (context) {
      return UtilPage();
    },
    widget: (context) {
      return WidgetPage();
    },
    setting: (context) {
      return SettingPage();
    },
    isolate: (context) {
      return IsolatePage();
    },
    // overview: (context) {
    //   return OverviewPage(ModalRoute.of(context).settings.arguments);
    // },
  };
}
