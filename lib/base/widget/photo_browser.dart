import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

// ignore: must_be_immutable
class PhotoBrowser extends StatefulWidget {
  List imgDataArr = [];
  final int index;
  final String heroTag;
  PageController controller;
  final GestureTapCallback onLongPress;
  final bool isHiddenClose;
  final bool isHiddenTitle;

  PhotoBrowser({
    Key key,
    @required this.imgDataArr,
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
    this.isHiddenClose = false,
    this.isHiddenTitle = false,
  }) : super(key: key) {
    controller = PageController(initialPage: index);
  }

  static show({
    @required BuildContext context,
    @required List images,
    int index,
    GestureTapCallback onLongPress,
    PageController controller,
  }) {
    Navigator.of(context).push(
      FadeRoute(
        page: PhotoBrowser(
          imgDataArr: images,
          index: index,
          onLongPress: onLongPress,
          controller: controller,
        ),
      ),
    );
  }

  @override
  _PhotoBrowserState createState() => _PhotoBrowserState();
}

class _PhotoBrowserState extends State<PhotoBrowser> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.imgDataArr.length > 1
            ? Text(
                "${currentIndex + 1}/${widget.imgDataArr.length}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            : null,
        iconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
        backgroundColor: Colors.black87,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              onLongPress: () {
                widget.onLongPress?.call();
              },
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  var _imgURL = widget.imgDataArr[index];
                  ImageProvider provider;
                  if (_imgURL is File) {
                    File file = _imgURL;
                    provider = FileImage(file);
                  } else if (_imgURL.startsWith('http')) {
                    provider = CachedNetworkImageProvider(_imgURL);
                  } else {
                    provider = AssetImage(_imgURL);
                  }
                  return PhotoViewGalleryPageOptions(
                    imageProvider: provider,
                    heroAttributes: widget.heroTag != null
                        ? PhotoViewHeroAttributes(tag: widget.heroTag)
                        : null,
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                itemCount: widget.imgDataArr.length,
                // loadingChild: Container(),
                backgroundDecoration: null,
                pageController: widget.controller,
                enableRotation: false,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: widget.imgDataArr.length == 1 ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imgDataArr.length,
                  (i) => GestureDetector(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.5),
                        child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                          radius: 3.5,
                          backgroundColor:
                              currentIndex == i ? _selColor : _otherColor,
                        )),
                  ),
                ).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
