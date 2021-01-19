import 'package:app_template/common/routes/demo_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List datas = [];

  @override
  void initState() {
    super.initState();
    datas..add("Util")..add("Widget")..add("isolate")..add("主题&&语言");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("首页"),
      ),
      body: ListView.builder(
        itemCount: datas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(datas[index]),
            onTap: () {
              onSelectItem(index);
            },
          );
        },
      ),
    );
  }

  void onSelectItem(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(DRoutes.util);
        break;
      case 1:
        Navigator.of(context).pushNamed(DRoutes.widget);
        break;
      case 2:
        Navigator.of(context).pushNamed(DRoutes.isolate);
        break;
      case 3:
        Navigator.of(context).pushNamed(DRoutes.setting);
        break;
      default:
    }
  }
}
