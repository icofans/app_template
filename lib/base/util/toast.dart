import 'package:app_template/base/intl/base_localizations.dart';
import 'package:app_template/base/util/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  // 普通Toast
  static void show({BuildContext context, IconData icon, String msg}) {
    if (context != null) {
      icon = icon ?? Icons.error;
      FToast fToast = FToast();
      fToast.removeCustomToast();
      fToast.init(context);
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xB2000000),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 44),
            SizedBox(height: 8.0),
            Text(
              msg ?? BaseLocalizations.of(context).unknown,
              style: TextStyle(
                fontSize: 15.spx,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      );
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(seconds: 1),
      );
    } else {
      Fluttertoast.showToast(
        msg: msg ?? "~",
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xB2000000),
        fontSize: 14.0.spx,
      );
    }
  }

  // 加载框
  static FToast fToast;
  static void showLoading({@required BuildContext context, String msg}) {
    if (context != null) {
      fToast = FToast();
      fToast.init(context);
      Widget toast = Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0x60000000),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            width: 200.0,
            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[50],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  child: Text(
                    msg ?? BaseLocalizations.of(context).loading,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.CENTER,
        toastDuration: Duration(seconds: 50),
      );
    }
  }

  static void hideLoading() {
    if (fToast != null) {
      fToast.removeCustomToast();
    }
  }
}
