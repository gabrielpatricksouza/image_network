library image_network;

import 'package:flutter/material.dart';
import 'package:image_network/src/app_image.dart';
import 'package:image_network/src/web/box_fit_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webviewx/webviewx.dart';
export 'package:image_network/src/web/box_fit_web.dart';

///Image Network for Flutter app (Android - Ios - Web)
///Flutter plugin based on the [webview_flutter] plugin

/// [image] is the url of the image you want to display.
///
///
/// [imageCache] is ImageProvider and can be used with CachedNetworkImageProvider.(Android && Ios)
///
///
/// [fitAndroidIos] How to inscribe the image into the space allocated during layout.(Android && Ios).
///
///
/// [fitWeb] How to inscribe the image into the space allocated during layout.(Web).
///
///
/// [height] is the height the image will occupy on the page.
///
///
/// [width] is the width the image will occupy on the page.
///
///
/// [duration] is the duration [milliseconds] of the animation.
///
///
/// [curve] is the animation curve.
///
///
/// [onPointer] true or false to display mouse focus.
///
///
/// [fullScreen] You can choose the option (true or false) to display the image
///              at 100% regardless of how much height or width you are using
///              the image.
///
/// [onTap] void function to click on the image.
///
///
/// [borderRadius] The border radius of the rounded corners. (Android - Ios - Web)
///
///
/// [onLoading] Widget for custom loading. (Android - Ios - Web)
///
///
/// [onError] Widget for custom error. (Android - Ios - Web)
///
///
class ImageNetwork extends StatefulWidget {
  final String image;
  final ImageProvider? imageCache;
  final BoxFit fitAndroidIos;
  final BoxFitWeb fitWeb;
  final double height;
  final double width;
  final int duration;
  final Curve curve;
  final bool onPointer;
  final bool fullScreen;
  final Function? onTap;
  final BorderRadius borderRadius;
  final Widget onLoading;
  final Widget onError;

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
    this.fitAndroidIos = BoxFit.cover,
    this.fitWeb = BoxFitWeb.cover,
    this.borderRadius = BorderRadius.zero,
    this.onLoading = const CircularProgressIndicator(),
    this.onError = const Icon(Icons.error),
    this.fullScreen = false,
    this.onTap,
    this.imageCache,
  }) : super(key: key);

  @override
  State<ImageNetwork> createState() => _ImageNetworkState();
}

class _ImageNetworkState extends State<ImageNetwork>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late WebViewXController webviewController;
  late Animation<double> _animation;

  /// bool variable used to validate (overlay with loading widget)
  /// while loading the image
  bool loading = true;

  /// bool variable used to validate (overlay with error widget)
  /// if an error occurs when loading the image
  bool error = false;

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
                fit: widget.fitAndroidIos,
                onTap: widget.onTap,
                borderRadius: widget.borderRadius,
                onLoading: widget.onLoading,
                onError: widget.onError,
                imageProvider: widget.imageCache,
              )
            : ClipRRect(
                borderRadius: widget.borderRadius,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: WebViewX(
                        key: const ValueKey('gabriel_patrick_souza'),
                        initialContent: _imagePage(
                          image: widget.image,
                          pointer: widget.onPointer,
                          fitWeb: widget.fitWeb,
                          fullScreen: widget.fullScreen,
                          height: widget.height,
                          width: widget.width,
                        ),
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
                            mobileJs:
                                "function onClick() { callback.postMessage() }",
                          ),
                          EmbeddedJsContent(
                            webJs: "function onLoad(msg) { callbackLoad(msg) }",
                            mobileJs:
                                "function onLoad(msg) { callbackLoad.postMessage(msg) }",
                          ),
                          EmbeddedJsContent(
                            webJs:
                                "function onError(msg) { callbackError(msg) }",
                            mobileJs:
                                "function onError(msg) { callbackError.postMessage(msg) }",
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
                          ),
                          DartCallback(
                            name: 'callbackLoad',
                            callBack: (msg) {
                              if (msg) {
                                setState(() => loading = false);
                              }
                            },
                          ),
                          DartCallback(
                            name: 'callbackError',
                            callBack: (msg) {
                              if (msg) {
                                setState(() => error = true);
                              }
                            },
                          ),
                        },
                        webSpecificParams: const WebSpecificParams(),
                        mobileSpecificParams: const MobileSpecificParams(
                          androidEnableHybridComposition: true,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: loading ? widget.onLoading : Container()),
                    Align(
                        alignment: Alignment.center,
                        child: error ? widget.onError : Container()),
                  ],
                ),
              ));
  }

  ///web page containing image only
  ///
  String _imagePage(
      {required String image,
      required bool pointer,
      required bool fullScreen,
      required double height,
      required double width,
      required BoxFitWeb fitWeb}) {
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
                      width: ${fullScreen ? "100%" : "$width" "px"};
                      height: ${fullScreen ? "100%" : "$height" "px"};
                      object-fit: ${fitWeb.name(fitWeb as Fit)};
                    }
                    #myImg:hover {opacity: ${pointer ? "0.7" : ""}};}
                </style>
                <meta charset="utf-8"
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
             </head>
             <body>
                <img id="myImg" src="$image" frameborder="0" allow="fullscreen"  allowfullscreen onclick= onClick() onerror= onError(this)>
                <script>
                  window.onload = function onLoad(){ callbackLoad(true);}
                </script>
             </body> 
            <script>
                function onClick() { callback() }
                function onError(source) { 
                  source.src = "https://scaffoldtecnologia.com.br/wp-content/uploads/2021/12/transparente.png";
                  source.onerror = ""; 
                  callbackError(true);
                  return true; 
                 }
            </script>
        </html>
    """;
  }
}
