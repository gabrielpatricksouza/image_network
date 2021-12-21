# Image Network

<p align="center">
  <img src="https://raw.githubusercontent.com/gabrielpatricksouza/image_network/master/preview/image.jpg" width=100%/>
</p>

Image Network is a package that allows you to render images on the web using CanvasKit without having problems with CORS.

<p align="start">
  <a href="https://pub.dev/packages/image_network">
    <img src="https://img.shields.io/badge/build-passing-green"
         alt="Build">
  </a>
  <a href="https://pub.dev/packages/image_network"><img src="https://img.shields.io/badge/pub-v2.1.0-blue"></a>

</p>

<p align="center">
  <img src="https://github.com/gabrielpatricksouza/image_network/blob/master/preview/new_example.gif?raw=true" width=56% hspace="10"/>
  <img src="https://github.com/gabrielpatricksouza/image_network/blob/master/preview/example_mobile.gif?raw=true" width=21% hspace="10"/>
</p>


## Features
* Image Manager (Android - Ios -Web)
* Use the CanvasKit renderer.
* No problems with CORS
* Fast loading
* Image cache (Android && Ios)
* Image from Url:
  * (Web) accept http or https image
  * (Android && Ios) accept https images 

## Installation

Add `image_network` as a dependency in your pubspec.yaml file .

Import Photo View:
```dart
import 'package:image_network/image_network.dart';
```

### Usage

#### URL Image
``` dart
String imageUrl = "https://scaffoldtecnologia.com.br/wp-content/uploads/2021/10/app-2.png";
```


#### Image Network

```dart
ImageNetwork(
    image: imageUrl,
    height: 450,
    width: 250,
    duration: 1500,
    curve: Curves.easeIn,
    onPointer: true,
    cacheAndroidIos: true,
    fitAndroidIos: BoxFit.cover,
    fitWeb: BoxFitWeb.cover,
    borderRadius: BorderRadius.circular(70),
    onTap: () {
      debugPrint("©gabriel_patrick_souza");
    },
  )
```

## License

Copyright (c) 2021 Gabriel Patrick Souza

[MIT License](https://github.com/gabrielpatricksouza/image_network/blob/master/LICENSE)
