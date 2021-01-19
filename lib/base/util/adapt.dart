import 'dart:ui';

class Adapt {
  static double physicalWidth;
  static double physicalHeight;
  static double screenWidth;
  static double screenHeight;
  static double _dpr;
  static double statusBarHeight;
  static double bottomBarHeight;

  static double wpx;
  static double hpx;
  static double spx;

  static void initialize({
    double designWidth,
    double designHeight,
  }) {
    /// 1. 手机的物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    /// 2. 求出dpr
    _dpr = window.devicePixelRatio;

    /// 3. 求出逻辑的宽高
    screenWidth = physicalWidth / _dpr;
    screenHeight = physicalHeight / _dpr;

    /// 4. 状态栏高度
    statusBarHeight = window.padding.top / _dpr;
    bottomBarHeight = window.padding.bottom / _dpr;

    /// 5. 计算rpx
    // rpx = screenWidth / designWidth * 2;
    wpx = screenWidth / designWidth;
    hpx = screenHeight / designHeight;
    spx = wpx;
  }

  static double setWpx(double size) {
    return size * wpx;
  }

  static double setHpx(double size) {
    return size * hpx;
  }

  static double setSpx(double size) {
    return size * spx;
  }
}

extension IntAdaptExtension on int {
  double get wpx {
    return Adapt.setWpx(this.toDouble());
  }

  double get hpx {
    return Adapt.setHpx(this.toDouble());
  }

  double get spx {
    return Adapt.setSpx(this.toDouble());
  }
}

extension DoubleAdaptExtension on double {
  double get wpx {
    return Adapt.setWpx(this);
  }

  double get hpx {
    return Adapt.setHpx(this);
  }

  double get spx {
    return Adapt.setSpx(this);
  }
}
