import 'package:app_template/base/config/config.dart';
import 'package:app_template/base/intl/base_localizations.dart';
import 'package:app_template/base/view_model/app_model/app_locale_model.dart';
import 'package:app_template/base/view_model/app_model/app_theme_model.dart';
import 'package:app_template/common/l10n/generated/l10n.dart';
import 'package:app_template/common/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // |---------------- base的一些配置 ---------------|
  Config config = Config.instance;
  // 初始一些东西
  config.initialize().then((value) {
    List locales = List()
      ..add({languageName: "简体中文", languageCode: "zh", countryCode: "CN"})
      // ..add({languageName: "繁体中文", languageCode: "tw", countryCode: "CH"})
      ..add({languageName: "English", languageCode: "en", countryCode: "US"});
    // ..add({languageName: "Português", languageCode: "pt", countryCode: "PT"});
    config
      // 配置适配设计稿尺寸
      ..configDesignInfo(designWidth: 375, designHeight: 667)
      // 配置http相关
      ..configEnv(Environment.dev)
      ..configBaseUrl(
          dev: "https://localserver.hivetech.iego.net:82/toilet-guanxian",
          testing: "null",
          production: "null")
      // 配置国际化
      ..configSupportedLocales(locales)
      // 屏幕方向
      ..configPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      // 状态栏沉浸
      ..configStatusBarImmerse()
      ..configTheme(
          primaryColor: Color(0xFF3B74F4),
          accentColor: Color(0xFF3B74F4).withAlpha(80));

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppThemeModel>(create: (_) => AppThemeModel()),
          ChangeNotifierProvider<AppLocaleModel>(
              create: (_) => AppLocaleModel()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: context.watch<AppThemeModel>().lightTheme,
      darkTheme: context.watch<AppThemeModel>().darkTheme,
      localizationsDelegates: const [
        S.delegate,
        BaseLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeListResolutionCallback: (locales, supportedLocales) {
        return;
      },
      localeResolutionCallback: (locale, supportedLocales) {
        return locale;
      },
      locale: context.watch<AppLocaleModel>().getLocale(),
      routes: Routes.routes,
      initialRoute: Routes.main,
      onGenerateRoute: Routes.onGenerateRoute,
      onGenerateTitle: (context) {
        // 后台指示器切换时的App名称
        return "App名称";
      },
    );
  }
}
