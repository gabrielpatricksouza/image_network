library image_network;

import 'package:flutter/material.dart';
import 'package:image_network/src/app_image.dart';
import 'package:webviewx/webviewx.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

///Image Network for Flutter app (Web)
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
/// [onClick] true or false to open image in new tab
///
///
/// [onPointer] true or false to display mouse focus
///
///
/// [onTap] void function to click on the image => [onClick] it has to be true
///
///
class ImageNetwork extends StatefulWidget {
  final String image;
  final BoxFit fitAndroidIos;
  final double height;
  final double width;
  final int duration;
  final Curve curve;
  final bool onPointer;
  final bool cacheAndroidIos;
  final Function? onTap;

  ///constructor
  ///
  ///
  const ImageNetwork({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    this.duration = 1200,
    this.curve = Curves.easeIn,
    this.onPointer = false,
    this.cacheAndroidIos = false,
    this.fitAndroidIos = BoxFit.cover,
    this.onTap,
  }) : super(key: key);

  @override
  State<ImageNetwork> createState() => _ImageNetworkState();
}

class _ImageNetworkState extends State<ImageNetwork>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late WebViewXController webviewController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation,
        child: kIsWeb == false
            ? AppImage(
                image: widget.image,
                height: widget.height,
                width: widget.width,
                cache: widget.cacheAndroidIos,
                fit: widget.fitAndroidIos,
                onTap: widget.onTap,
              )
            : WebViewX(
                key: const ValueKey('gabriel_patrick_souza'),
                initialContent: _imagePage(widget.image, widget.onPointer),
                initialSourceType: SourceType.html,
                height: widget.height,
                width: widget.width,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) =>
                    webviewController = controller,
                onPageFinished: (src) =>
                    debugPrint('✓ The page has finished loading!\n'),
                jsContent: const {
                  EmbeddedJsContent(
                    webJs: "function onClick() { callback() }",
                    mobileJs: "function onClick() { callback.postMessage() }",
                  ),
                },
                dartCallBacks: {
                  DartCallback(
                    name: 'callback',
                    callBack: (msg) {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                  )
                },
                webSpecificParams: const WebSpecificParams(),
                mobileSpecificParams: const MobileSpecificParams(
                  androidEnableHybridComposition: true,
                ),
              ));
  }

  ///web page containing image only
  ///
  String _imagePage(String image, bool pointer) {
    return """<!DOCTYPE html>
            <html>
              <head>
                <style  type="text/css" rel="stylesheet">
                  body {
                    margin: 0px;
                    height: 100%;
                    width: 100%;
	                  overflow: hidden;
                   }
                  
                    #myImg {
                      cursor: ${pointer ? "pointer" : ""};
                      transition: 0.3s;
                    }
                    #myImg:hover {opacity: ${pointer ? "0.7" : ""}};}
                </style>
                
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                <img id="myImg" src="$image" width="100%" height="100%" 
                      frameborder="0" allow="fullscreen"  allowfullscreen 
                      onclick= onClick()>
             </body> 
             
            <script>
                function onClick() { callback() }
            </script>
        </html>
    """;
  }
}
