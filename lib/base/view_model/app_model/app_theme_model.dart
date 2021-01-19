import 'package:app_template/base/config/config.dart';
import 'package:app_template/base/util/adapt.dart';
import 'package:app_template/base/util/sp.dart';
import 'package:flutter/material.dart';

enum AppThemeMode {
  auto,
  light,
  dark,
}

class AppThemeModel extends ChangeNotifier {
  final Sp sp = Sp.instance;

  void changeTheme(AppThemeMode mode) {
    if (mode == currentThemeMode) return;
    sp.setInt("themeMode", mode.index);
    notifyListeners();
  }

  AppThemeMode get currentThemeMode {
    int mode = sp.getInt("themeMode");
    return AppThemeMode.values[(mode ?? 0)];
  }

  // 亮色主题
  ThemeData get lightTheme {
    return _getTheme();
  }

  // 深色主题
  ThemeData get darkTheme {
    return _getTheme(isDarkMode: true);
  }

  ThemeData _getTheme({bool isDarkMode = false}) {
    Brightness brightness;
    switch (currentThemeMode) {
      case AppThemeMode.auto:
        brightness = isDarkMode ? Brightness.dark : Brightness.light;
        break;
      case AppThemeMode.light:
        brightness = Brightness.light;
        isDarkMode = false;
        break;
      case AppThemeMode.dark:
        brightness = Brightness.dark;
        isDarkMode = true;
        break;
      default:
    }
    return ThemeData(
      // fontFamily: 'PingFangSC',
      // 应用程序的整体主题亮度
      brightness: brightness,
      // 大多数Widget的颜色，如进度条、开关等。主色调,蓝色
      accentColor: Config.instance.accentColor ?? Colors.blue,
      // 整体背景色
      scaffoldBackgroundColor:
          isDarkMode ? Color(0xFF2c2c2c) : Color(0xFFF4F6F9),
      dividerColor: isDarkMode ? Color(0xFF2c2c2c) : Color(0xFFF4F6F9),
      primaryColor: Config.instance.primaryColor ?? Colors.blue, // App主要部分的背景色
      buttonTheme: ButtonThemeData(
        minWidth: 0,
        buttonColor: Color(0xFF3B74F4),
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        // 蓝色 大小 16 字重 Semibold
        headline1: TextStyle(
          color: Color(0xFF3B74F4),
          fontSize: 16.spx,
          fontWeight: FontWeight.w600,
        ),
        headline2: TextStyle(
          color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
          fontSize: 16.spx,
          fontWeight: FontWeight.w600,
        ),
        // 15号字体, 如Listtile的标题样式
        subtitle1: TextStyle(
          color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
          fontSize: 15.spx,
          fontWeight: FontWeight.w500,
        ),
        // 15号字体, 如Listtile的子标题样式
        subtitle2: TextStyle(
          color: isDarkMode ? Color(0xFF999999) : Color(0xFF666666),
          fontSize: 15.spx,
          fontWeight: FontWeight.w400,
        ),
        // 16号字体, 标题样式
        bodyText1: TextStyle(
          color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
          fontSize: 16.spx,
          fontWeight: FontWeight.w500,
        ),
        // 16号字体, 子标题样式
        bodyText2: TextStyle(
          color: isDarkMode ? Color(0xFF999999) : Color(0xFF666666),
          fontSize: 16.spx,
          fontWeight: FontWeight.w400,
        ),
      ),
      appBarTheme: AppBarTheme(
        // actionsIconTheme: IconThemeData(size: 16),
        // iconTheme: IconThemeData(size: 16),
        elevation: 0, // 去阴影
        centerTitle: true,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
            fontSize: 16.spx,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
        ),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        color: isDarkMode ? Color(0xFF202020) : Colors.white,
      ),
      cardTheme: CardTheme(
        // 去iOS卡片阴影
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        margin: EdgeInsets.symmetric(horizontal: 14.wpx, vertical: 8.wpx),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
