import 'package:app_template/base/widget/empty_view.dart';
import 'package:app_template/base/widget/error_view.dart';
import 'package:app_template/base/widget/loading_view.dart';
import 'package:app_template/base/widget/provider_widget.dart';
import 'package:app_template/pages/demo/widget/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class WidgetPage extends StatefulWidget {
  WidgetPage({Key key}) : super(key: key);

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  WidgetModel m = WidgetModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
        actions: [
          TextButton(
              onPressed: () {
                m.resetData();
              },
              child: Text("空的")),
        ],
      ),
      body: ProviderWidget<WidgetModel>(
        builder: (context, model, child) {
          print("${model.count} ==== ${model.datas.length}");
          return EasyRefresh(
            header: BallPulseHeader(),
            footer: BallPulseFooter(),
            controller: model.refreshController,
            onLoad: model.loadEnabled ? model.onLoad : null,
            onRefresh: model.onRefresh,
            firstRefresh: true,
            firstRefreshWidget: LoadingView(message: "加载中"),
            emptyWidget: model.isEmpty
                ? EmptyView(message: "空空如也")
                : (model.isError
                    ? ErrorView(
                        message: "加载失败",
                        title: "未知错误",
                        buttonText: "重试",
                        onTap: () {
                          model.failData = false;
                          model.initData();
                        },
                        loadingView: LoadingView(message: "重试中"),
                      )
                    : null),
            child: ListView.builder(
              itemCount: model.datas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(model.datas[index].toString()),
                );
              },
            ),
          );
        },
        model: m,
        // onModelReady: (model) {
        //   // model.initData();
        // },
      ),
    );
  }
}
