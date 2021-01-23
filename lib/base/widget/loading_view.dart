import 'package:app_template/base/intl/base_localizations.dart';
import 'package:app_template/base/util/adapt.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String message;

  const LoadingView({Key key, this.message}) : super(key: key);
  @override
  Widget build(Object context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.grey[50],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16.wpx),
            Text(
              message ?? BaseLocalizations.of(context).loading,
              style: TextStyle(color: Color(0xFF999999), fontSize: 14.spx),
            ),
          ],
        ),
      ),
    );
  }
}
