import 'package:app_template/base/intl/base_localizations.dart';
import 'package:app_template/base/util/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert {
  // 显示Error
  static showError({
    @required BuildContext context,
    String title,
    @required String content,
    String confirmText,
    void Function() onConfirm,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return CupertinoAlertDialog(
          title: title == null
              ? null
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.wpx,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
                  ),
                ),
          content: Text(
            content ?? "",
            style: TextStyle(
              fontSize: 12.spx,
              height: 1.8,
              color: isDarkMode ? Color(0xFF999999) : Color(0xFF666666),
            ),
          ),
          actions: <Widget>[
            Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    onConfirm?.call();
                  },
                  child: FlatButton(
                    child: new Text(
                      confirmText ?? BaseLocalizations.of(context).confirmText,
                      style: TextStyle(
                        color: Color(0xFF3A6FEE),
                        fontSize: 14.spx,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Alert
  static showAlert({
    @required BuildContext context,
    String title,
    @required String content,
    Color color,
    String cancelText,
    String confirmText,
    void Function() onCancel,
    void Function() onConfirm,
  }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.spx,
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
                  ),
                )
              : null,
          content: Text(
            content,
            style: TextStyle(
              fontSize: 14.spx,
              height: 1.8,
              color: isDarkMode ? Color(0xFF999999) : Color(0xFF666666),
            ),
          ),
          actions: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Container(
                  child: FlatButton(
                    child: Text(
                      cancelText ?? BaseLocalizations.of(context).cancelText,
                      style: TextStyle(
                        color:
                            isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
                        fontSize: 14.spx,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
                child: Container(
                  child: FlatButton(
                    child: new Text(
                      confirmText ?? BaseLocalizations.of(context).confirmText,
                      style: TextStyle(
                        color: color ??
                            (isDarkMode
                                ? Color(0xFFd1d1d1)
                                : Color(0xFF333333)),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.spx,
                      ),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static showBottomSheet({
    @required BuildContext context,
    @required List items,
    String itemKey,
    void Function(int index) onSelected,
    String cancelText,
  }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        List<Widget> widgets = <Widget>[];
        for (var i = 0; i < items.length; i++) {
          var item = items[i];
          String title = "";
          if (item is Map) {
            title = item[itemKey] ?? "";
          } else {
            title = item;
          }
          Widget w = ListTile(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.spx,
                color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
              ),
            ),
            onTap: () {
              Navigator.pop(context, i);
            },
          );
          Widget line = Container(
            color: isDarkMode ? Color(0xFF646464) : Color(0xFFf1f3f6),
            height: 1,
          );
          widgets.add(w);
          widgets.add(line);
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: widgets,
                ),
              ),
              Container(
                color: isDarkMode ? Color(0xFF646464) : Color(0xFFf1f3f6),
                height: 5,
              ),
              ListTile(
                title: Text(
                  cancelText ?? BaseLocalizations.of(context).cancelText,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    ).then((value) {
      if (value == null) return;
      onSelected?.call(value);
    });
  }

  /// 显示Picker
  static void showPicker({
    @required BuildContext context,
    @required List datas,
    String dataKey,
    int initialItem = 0,
    String cancelText,
    String confirmText,
    void Function() onCancel,
    void Function(int index) onConfirm,
  }) {
    // controller
    FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initialItem);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int selectedValue = initialItem;
    List<Widget> widgets = <Widget>[];
    for (var item in datas) {
      String title = "";
      if (item is Map) {
        title = item[dataKey] ?? "";
      } else {
        title = item;
      }
      Widget container = Container(
        height: 40.wpx,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.spx,
              color: isDarkMode ? Color(0xFFd1d1d1) : Color(0xFF333333),
            ),
          ),
        ),
      );
      widgets.add(container);
    }
    // if (custom != null) {
    //   Widget container = Container(
    //     height: 35.px,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image(
    //           image: Util.imageNamed("ico_edit_tag"),
    //           color: Util.color000(context),
    //         ),
    //         SizedBox(width: Util.setWidth(3)),
    //         Text(
    //           custom,
    //           style: TextStyle(
    //               fontSize: Util.font15, color: Util.color333(context)),
    //         ),
    //       ],
    //     ),
    //   );
    // widgets.add(container);
    // }

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: isDarkMode ? Color(0xFF202020) : Colors.white,
          height: 250.wpx,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 8.wpx),
                  TextButton(
                    // padding: EdgeInsets.symmetric(vertical: 10.px),
                    // color: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                      onCancel?.call();
                    },
                    child: Text(
                      cancelText ?? BaseLocalizations.of(context).cancelText,
                      style: TextStyle(
                          color: isDarkMode
                              ? Color(0xFF999999)
                              : Color(0xFF666666),
                          fontSize: 15.spx),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    // padding: EdgeInsets.symmetric(vertical: 10.px),
                    // color: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call(selectedValue);
                    },
                    child: Text(
                      confirmText ?? BaseLocalizations.of(context).confirmText,
                      style:
                          TextStyle(color: Color(0xFF3A6FEE), fontSize: 15.spx),
                    ),
                  ),
                  SizedBox(width: 8.wpx),
                ],
              ),
              Expanded(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: isDarkMode ? Color(0xFFffffff) : Color(0xFF000000),
                    fontSize: 22,
                  ),
                  child: CupertinoPicker(
                    backgroundColor:
                        isDarkMode ? Color(0xFF202020) : Colors.white,
                    scrollController: scrollController,
                    itemExtent: 40.wpx,
                    onSelectedItemChanged: (value) {
                      selectedValue = value;
                    },
                    children: widgets,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
