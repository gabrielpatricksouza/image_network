import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppImage extends StatefulWidget {
  final String image;
  final BoxFit fit;
  final double height;
  final double width;
  final Function? onTap;
  final BorderRadius borderRadius;
  final Widget onLoading;
  final Widget onError;
  final ImageProvider? imageProvider;

  const AppImage({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.fit,
    required this.onTap,
    required this.borderRadius,
    required this.onLoading,
    required this.onError,
    this.imageProvider,
  }) : super(key: key);

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  /// bool variable used to validate (overlay with error widget)
  /// if an error occurs when loading the image
  bool imageError = false;

  @override
  void initState() {
    checkImageProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: widget.imageProvider != null

              /// Error Handling
              ? imageError
                  ? widget.onError
                  : Image(
                      image: widget.imageProvider!,
                      height: widget.height,
                      width: widget.width,
                      fit: widget.fit,
                    )
              : FutureBuilder(
                  future: getUrlResponse(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: widget.onLoading);
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) return widget.onError;
                        if (!snapshot.hasData) return widget.onError;
                        return Image.memory(
                          snapshot.data!,
                          height: widget.height,
                          width: widget.width,
                          fit: widget.fit,
                        );
                    }
                  },
                ),
        ),
      ),
    );
  }

  Future getUrlResponse() async {
    final response = await http.get(Uri.parse(widget.image));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      debugPrint("Http request error! [${response.statusCode}]");
    }
  }

  Future checkImageProvider() async {
    final response = await http.get(Uri.parse(widget.image));
    if (response.statusCode != 200) {
      debugPrint("Http request error! [${response.statusCode}]");
      setState(() => imageError = true);
    }
  }
}
