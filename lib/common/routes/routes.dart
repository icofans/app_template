import 'package:app_template/common/global/global.dart';
import 'package:app_template/common/routes/demo_routes.dart';
import 'package:app_template/pages/main/main_page.dart';
import 'package:app_template/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class Routes with DRoutes {
  /// 路由定义
  ///
  /// Routes.main
  static const String main = "/";
  static const String login = "/login";
  static const String loginIdentity = "/login_identity";
  static const String locale = "/locale";
  static const String about = "/about";
  static const String language = "/language";
  static const String aboutAgreement = "/about/agreement";
  static const String switchMap = "/map_switch";

  static DRoutes demo;

  /// 路由Map集合
  ///
  /// Routes.routes
  static get routes {
    Map routes = <String, WidgetBuilder>{
      login: (context) => LoginPage(),
    };
    routes.addAll(DRoutes.dRoutes);
    return routes;
  }

  /// 路由拦截函数
  ///
  /// Routes.onGenerateRoute
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name;
    if (routeName == main) {
      ///
      Global.instance.isLogin = true;
      if (Global.instance.isLogin) {
        return MaterialPageRoute(
          builder: (context) {
            return MainPage();
          },
        );
      } else {
        return MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        );
      }
    }
    return MaterialPageRoute(builder: (context) => null);
  }
}
