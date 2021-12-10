library image_network;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

///Image Network for Flutter apps (Android - IOS - Web)
///Flutter plugin based on the [webview_flutter] plugin


/// [image] is the url of the image you want to display
///
///
/// [height] is the height the image will occupy on the page
///
///
/// [width] is the width the image will occupy on the page
///
///
/// [duration] is the duration [milliseconds] of the animation
///
///
/// [curve] is the animation curve
///
///
class ImageNetwork extends StatefulWidget {
  final String image;
  final double height;
  final double width;
  final int duration;
  final Curve curve;

  ///constructor
  ///
  ///
  ///
  const ImageNetwork({
    Key? key,
    required this.image, required this.height, required this.width,
    this.duration = 1200, this.curve = Curves.easeIn,
  }) : super(key: key);

  @override
  State<ImageNetwork> createState() => _ImageNetworkState();
}

class _ImageNetworkState extends State<ImageNetwork> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    if (kIsWeb) WebView.platform = WebWebViewPlatform();
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller!, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller!.forward();

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: FadeTransition(
        opacity: _animation!,
        child: WebView(
          initialUrl: _imagePage(widget.image),
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  ///web page containing image only
  ///
  String _imagePage(String image) {
    final html = '''
            <html>
              <head>
                <style  type="text/css" rel="stylesheet">
                  body {
                    margin: 0px;
                    height: 100%;
                    width: 100%;
                   }
                   
                   img {
                      min-width: 100%;
                      min-height: 100%;
                    }
                    
                </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                <img src="$image"  width="100%" height="100%" frameborder="0" allow="fullscreen"  allowfullscreen>
             </body> 
            </html>
            ''';
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(html));
    return 'data:text/html;base64,$contentBase64';
  }
}