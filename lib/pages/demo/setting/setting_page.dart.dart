import 'package:app_template/base/view_model/app_model/app_locale_model.dart';
import 'package:app_template/base/view_model/app_model/app_theme_model.dart';
import 'package:app_template/base/widget/feedback_widget.dart';
import 'package:app_template/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "当前语言: " +
                        (context.watch<AppLocaleModel>().currentLanguageName ??
                            "跟随系统"),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    S.of(context).test,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Row(
              children: [
                _buildItem(
                  title: "跟随系统",
                  onTap: () {
                    context.read<AppLocaleModel>().changeLocale(null);
                  },
                ),
                _buildItem(
                  title: "简体中文",
                  onTap: () {
                    context.read<AppLocaleModel>().changeLocale(0);
                  },
                ),
                _buildItem(
                  title: "English",
                  onTap: () {
                    context.read<AppLocaleModel>().changeLocale(1);
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            width: double.infinity,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "当前主题: " +
                        (["跟随系统", "亮色模式", "深色模式"][context
                            .watch<AppThemeModel>()
                            .currentThemeMode
                            .index]),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Row(
              children: [
                _buildItem(
                  title: "跟随系统",
                  onTap: () {
                    context
                        .read<AppThemeModel>()
                        .changeTheme(AppThemeMode.auto);
                  },
                ),
                _buildItem(
                  title: "亮色模式",
                  onTap: () {
                    context
                        .read<AppThemeModel>()
                        .changeTheme(AppThemeMode.light);
                  },
                ),
                _buildItem(
                  title: "深色模式",
                  onTap: () {
                    context
                        .read<AppThemeModel>()
                        .changeTheme(AppThemeMode.dark);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem({String title, void Function() onTap}) {
    return Expanded(
      child: FeedbackWidget(
          child: Container(
            margin: EdgeInsets.all(16),
            height: 80,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          a: 0.9,
          onPressed: onTap),
    );
  }
}
