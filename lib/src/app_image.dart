import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'services/get_cache_service.dart';
import 'services/internet_service.dart';
import 'services/set_cache_service.dart';

class AppImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double height;
  final double width;
  final bool cache;
  final Function? onTap;
  final BorderRadius borderRadius;
  final Widget onLoading;
  final Widget onError;

  const AppImage({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.fit,
    required this.cache,
    required this.onTap,
    required this.borderRadius,
    required this.onLoading,
    required this.onError,
  }) : super(key: key);

  Future getUrlResponse() async {
    if (cache) {
      final prefs = await SharedPreferences.getInstance();
      final setCache = AcessSetCache(prefs);
      final getCache = AcessGetCache(prefs);

      var responseCache = await getCache.cache(image);
      if (responseCache != null) {
        return base64Decode(responseCache);
      } else {
        if (await CheckInternet.isConnect) {
          final response = await http.get(Uri.parse(image));
          await setCache.cache(image, base64Encode(response.bodyBytes));
          if (response.statusCode == 200) {
            return response.bodyBytes;
          } else {
            debugPrint("Http request error! [${response.statusCode}]");
          }
        }
      }
    }

    final response = await http.get(Uri.parse(image));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      debugPrint("Http request error! [${response.statusCode}]");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
            height: height,
            width: width,
            child: FutureBuilder(
              future: getUrlResponse(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: onLoading);
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) return onError;
                    if (!snapshot.hasData) return onError;
                    return Image.memory(
                      snapshot.data!,
                      height: height,
                      width: width,
                      fit: fit,
                    );
                }
              },
            )),
      ),
    );
  }
}
