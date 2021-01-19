import 'package:app_template/base/isolate/app_private_ioslate.dart';
import 'package:flutter/material.dart';

class IsolatePage extends StatefulWidget {
  IsolatePage({Key key}) : super(key: key);

  @override
  _IsolatePageState createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("isolate"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            AppPrivateIsolate.getInstance().initNetObserver();
          },
          child: Text("开启网络监测"),
        ),
      ),
    );
  }
}
