
# 🌐 Image Network

<p align="center">
  <img src="https://github.com/gabrielpatricksouza/image_network/blob/v2.5.5/readme/banner_v2.png" width=100%/>
</p>

Image Network is a package that allows you to render images on the web using CanvasKit without having problems with CORS.

<p align="start">
  <a href="https://pub.dev/packages/image_network">
    <img src="https://img.shields.io/badge/build-passing-green"
         alt="Build">
  </a>
  <a href="https://pub.dev/packages/image_network"><img src="https://img.shields.io/badge/pub-v2.5.5-blue"></a>

</p>


<p align="center">
  <img src="https://github.com/gabrielpatricksouza/image_network/blob/v2.5.5/readme/web_android_iOS.gif" width=50% hspace="10"/>
</p>


## 📚 Features
* Image Manager (Android - iOS - Web)
* Use the CanvasKit renderer
* No problems with CORS
* Fast loading
* Image cache (Android && iOS) 
  * Recommended using with CachedNetworkImage version 2.2.0 or newer
* Image from Url:
  * (Web) accept http or https image
  * (Android && iOS) accept https images
* Supported Image Formats
  * PNG 
  * JPEG
  * GIF / Animated GIF

## 🔌 Installation

Add `image_network` as a dependency in your pubspec.yaml file .

Import Image Network:
```dart
import 'package:image_network/image_network.dart';
```

## 👨‍💻 How To Use

#### URL Image
``` dart
String imageUrl = "https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png";
```


#### Image Network

```dart
ImageNetwork(
    image: imageUrl,
    height: 350.0,
    width: 240.0,
    duration: 1500,
    curve: Curves.easeIn,
    onPointer: true,
    debugPrint: false,
    backgroundColor: Colors.blue,
    fitAndroidIos: BoxFit.cover,
    fitWeb: BoxFitWeb.cover,
    borderRadius: BorderRadius.circular(70),
    onLoading: const CircularProgressIndicator(
      color: Colors.indigoAccent,
    ),
    onError: const Icon(
      Icons.error,
      color: Colors.red,
    ),
    onTap: () {
      debugPrint("©gabriel_patrick_souza");
    },
  )
```

## ☀️ License

Copyright (c) 2021 Gabriel Patrick Souza

[MIT License](https://github.com/gabrielpatricksouza/image_network/blob/master/LICENSE)
