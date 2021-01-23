import 'package:app_template/base/intl/base_localizations.dart';
import 'package:app_template/base/util/adapt.dart';
import 'package:app_template/base/widget/widgets.dart';
import 'package:flutter/material.dart';

const String networkErrorImage = "assets/images/ico_network_error.png";
const String defaultErrorImage = "assets/images/ico_error.png";
const IconData networkErrorIcon = IconData(0xe6c1, fontFamily: "iconfont");
const IconData defaultErrorIcon = IconData(0xe61b, fontFamily: "iconfont");

enum ErrorType {
  unknown,
  network,
}

class ErrorView extends StatelessWidget {
  final String image;
  final String title;
  final String message;
  final String buttonText;
  final void Function() onTap;
  final ErrorType errorType;
  final Widget loadingView;
  const ErrorView(
      {Key key,
      this.image,
      this.title,
      this.message,
      this.buttonText,
      this.loadingView,
      this.errorType = ErrorType.unknown,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = loadingView ??
        LoadingView(
          message: BaseLocalizations.of(context).retryLoadingText,
        );
    bool retryLoading = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return retryLoading
            ? loadingWidget
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  image == null
                      ? Icon(
                          (errorType == ErrorType.unknown
                              ? defaultErrorIcon
                              : networkErrorIcon),
                          size: 150.wpx,
                        )
                      : Image(
                          image: AssetImage(image),
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.wpx, vertical: 16.wpx),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title ?? BaseLocalizations.of(context).error,
                          style: TextStyle(
                            fontSize: 15.spx,
                            color: Color(0xFF999999),
                          ),
                        ),
                        SizedBox(height: 8.wpx),
                        Text(
                          message ?? BaseLocalizations.of(context).errorTip,
                          style: TextStyle(
                            fontSize: 13.spx,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 28.wpx,
                      child: OutlineButton(
                        borderSide:
                            BorderSide(color: Colors.blue[300], width: 1),
                        child: Text(
                          buttonText ?? BaseLocalizations.of(context).retryText,
                          style: TextStyle(
                              wordSpacing: 5, color: Colors.blue[300]),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.spx),
                          ),
                        ),
                        textColor: Colors.grey,
                        splashColor: Theme.of(context).splashColor,
                        onPressed: () {
                          if (loadingWidget != null) {
                            setState(() {
                              retryLoading = true;
                            });
                          }
                          onTap?.call();
                        },
                        highlightedBorderColor: Theme.of(context).splashColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 120.wpx)
                ],
              );
      },
    );
  }
}
