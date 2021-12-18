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

  const AppImage({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
    required this.fit,
    required this.cache,
  }) : super(key: key);

  Future<Uint8List> getUrlResponse() async {
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
          return response.bodyBytes;
        }
      }
    }

    final response = await http.get(Uri.parse(image));
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: FutureBuilder(
          future: getUrlResponse(),
          builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) return const Icon(Icons.error);
                if (!snapshot.hasData) return const Icon(Icons.error);
                return Image.memory(
                  snapshot.data!,
                  height: height,
                  width: width,
                  fit: fit,
                );
            }
          },
        ));
  }
}
