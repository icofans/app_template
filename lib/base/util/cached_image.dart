import 'package:app_template/base/util/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage {
  static CachedNetworkImage assetNetwork({
    @required String imageUrl,
    String plahoder = "assets/images/ico_placeholder.png",
    BoxFit fit = BoxFit.cover,
    double width,
    double height,
    Color backgroudColor,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: backgroudColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF424242)
                : Color(0xFFF8F9FC)),
        child: Center(
          child: Text(
            "loading...",
            style: TextStyle(fontSize: 12.spx),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: backgroudColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF424242)
                : Color(0xFFF8F9FC)),
        child: Center(
          child: Icon(
            Icons.broken_image,
          ),
        ),
      ),
    );
  }
}
