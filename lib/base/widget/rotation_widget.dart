import 'package:flutter/material.dart';

/// 旋转Icon
///
class RotationWidget extends StatefulWidget {
  final void Function() onTap;
  final bool animation;
  final Widget child;
  const RotationWidget({Key key, this.onTap, this.animation, this.child})
      : super(key: key);
  @override
  _RotationWidgetState createState() {
    return _RotationWidgetState();
  }
}

class _RotationWidget extends AnimatedWidget {
  final void Function() onTap;
  final bool showAnimation;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    Widget widget = (child ??
        Icon(
          Icons.autorenew,
          color: Color(0xFF327FF4),
          size: 19,
        ));
    return showAnimation
        ? RotationTransition(
            alignment: Alignment.center,
            turns: animation,
            child: widget,
          )
        : widget;
  }

  _RotationWidget(
      {Key key,
      Animation<double> animation,
      this.child,
      this.showAnimation,
      this.onTap})
      : super(key: key, listenable: animation);
}

class _RotationWidgetState extends State<RotationWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  AnimationStatus animationStatus;
  double animationvalue;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RotationWidget(
      showAnimation: widget.animation,
      animation: animation,
      child: widget.child,
      onTap: widget.onTap,
    );
  }
}
