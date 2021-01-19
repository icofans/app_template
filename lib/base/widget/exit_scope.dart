import 'package:app_template/base/util/toast.dart';
import 'package:flutter/material.dart';

/// 安卓双击退出
///
///
class ExitScope extends StatefulWidget {
  const ExitScope({
    Key key,
    this.message,
    @required this.child,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Widget child;

  /// 两次点击返回按钮的时间间隔
  final Duration duration;

  final String message;

  @override
  _ExitScopeState createState() => _ExitScopeState();
}

class _ExitScopeState extends State<ExitScope> {
  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _ifExit(context),
      child: widget.child,
    );
  }

  Future<bool> _ifExit(BuildContext context) {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();

      Toast.show(msg: widget.message ?? "双击退出");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
