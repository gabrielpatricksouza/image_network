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
  <a href="https://pub.dev/packages/image_network"><img src="https://img.shields.io/badge/pub-v2.0.0-blue"></a>

</p>

<p align="center">
  <img src="https://github.com/gabrielpatricksouza/image_network/blob/master/preview/example.gif?raw=true"/>
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

#### URLs Images
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
    onTap: () {
      debugPrint("©gabriel_patrick_souza");
    },
  )
```

## License

Copyright (c) 2021 Gabriel Patrick Souza

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
