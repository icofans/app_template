import 'dart:io';

import 'package:package_info/package_info.dart';

class Package {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;

  static Future<PackageInfo> getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
}
