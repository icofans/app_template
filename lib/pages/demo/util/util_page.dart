import 'package:app_template/base/util/util.dart';
import 'package:app_template/pages/demo/util/sp_model.dart';
import 'package:app_template/pages/demo/util/toast_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UtilPage extends StatefulWidget {
  UtilPage({Key key}) : super(key: key);

  @override
  _UtilPageState createState() => _UtilPageState();
}

class _UtilPageState extends State<UtilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Util"),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<SpModel>(create: (_) => SpModel()),
          ChangeNotifierProvider<ToastModel>(create: (_) => ToastModel()),
        ],
        builder: (context, child) {
          return ListView(
            children: [
              Text("toast"),
              RaisedButton(
                onPressed: () {
                  Toast.show(msg: "这是一个Toast");
                },
                child: Text("无context的toast"),
              ),
              RaisedButton(
                onPressed: () {
                  Toast.show(context: context, msg: "这是一个Toast");
                },
                child: Text("有context的toast"),
              ),
              RaisedButton(
                onPressed: () {
                  Toast.showLoading(context: context, msg: "加载中");
                  context.read<ToastModel>().fetchData(
                    onDone: () {
                      Toast.hideLoading();
                    },
                  );
                },
                child: Text(
                  context.select((ToastModel value) => value.buttonText),
                ),
              ),
              Text("alert"),
              RaisedButton(
                onPressed: () {
                  Alert.showError(
                    context: context,
                    title: "提示",
                    content: "这是一个提示框",
                    confirmText: "确认",
                  );
                },
                child: Text("这是一个按钮的提示框"),
              ),
              RaisedButton(
                onPressed: () {
                  Alert.showAlert(
                    context: context,
                    title: "提示",
                    content: "这是个提示框",
                    cancelText: "取消",
                    confirmText: "确认",
                  );
                },
                child: Text("这是两个按钮的提示框"),
              ),
              RaisedButton(
                onPressed: () {
                  Alert.showBottomSheet(
                    context: context,
                    items: ["1", "2", "3", "4", "6", "8", "19", "32", "34234"],
                    cancelText: "取消",
                  );
                },
                child: Text("这是底部框"),
              ),
              RaisedButton(
                onPressed: () {
                  Alert.showPicker(
                    context: context,
                    datas: ["1", "2", "3", "4", "6", "8", "19", "32", "34234"],
                    cancelText: "取消",
                    confirmText: "确认",
                  );
                },
                child: Text("这是底部选择框"),
              ),
              Text("sp"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      context.read<SpModel>().saveData();
                    },
                    child: Text("存值"),
                  ),
                  AW(),
                  // Text(context.select((SpModel p) => p.savaStr)),
                  RaisedButton(
                    onPressed: () {
                      context.read<SpModel>().getData();
                    },
                    child: Text("取值"),
                  ),
                  BW(),
                  // Text(context.select((SpModel p) => p.str)),
                ],
              ),
              Text("package"),
              Row(
                children: [
                  FutureBuilder(
                    future: Package.getVersion(),
                    builder: (context, snapshot) {
                      return Text("版本号:" + snapshot.data.toString() ?? "");
                    },
                  ),
                  FutureBuilder(
                    future: Package.getPackageName(),
                    builder: (context, snapshot) {
                      return Text("包名:" + snapshot.data.toString() ?? "");
                    },
                  )
                ],
              ),
              Text("Adapt"),
              Text("宽比例: " + Adapt.wpx.toString()),
              Text("高比例: " + Adapt.hpx.toString()),
              Text("屏幕宽度: " + Adapt.screenWidth.toString()),
              Text("屏幕高度: " + Adapt.screenHeight.toString()),
              Text("状态栏: " + Adapt.statusBarHeight.toString()),
              Text("底部bar: " + Adapt.bottomBarHeight.toString()),
              Text("NetworkImage"),
              CachedImage.assetNetwork(
                imageUrl:
                    "https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3397537705,1180362904&fm=26&gp=0.jpg",
                width: 200,
                height: 400,
                fit: BoxFit.fitWidth,
              ),
            ],
          );
        },
      ),
    );
  }
}

class AW extends StatelessWidget {
  const AW({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("AW刷新");
    return Text(context.select((SpModel p) => p.savaStr));
  }
}

class BW extends StatelessWidget {
  const BW({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BW刷新");
    return Text(context.select((SpModel p) => p.str));
  }
}
