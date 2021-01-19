import 'package:app_template/base/util/adapt.dart';
import 'package:flutter/material.dart';

const String emptyImage = "assets/images/ico_empty.png";
const IconData emptyIcon = IconData(0xe618, fontFamily: "iconfont");

/// 空白视图
///
///
class EmptyView extends StatelessWidget {
  final String image;
  final String message;
  const EmptyView({Key key, @required this.message, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 155 / 88,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: AssetImage(
                image ?? emptyImage,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.wpx),
        Text(
          message ?? "",
          style: TextStyle(
            fontSize: 17.spx,
            color: Color(0xFFc4d1f5),
          ),
        )
      ],
    );
  }
}
