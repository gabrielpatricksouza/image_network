## 2.1.0

* Added option to embed BoxFit in Image for Android && IOs
```dart
fitAndroidIos: BoxFit.cover,
```

* Added option to embed BoxFit in Image for Web
```dart
fitWeb: BoxFitWeb.cover,
```

* Added option to insert border radius in Image
```dart
borderRadius: BorderRadius.circular(70),
```

## 2.0.0

* Added new way to display image

* Added option to show mouse pointer:
```dart
onPointer: true, // or false
```

* Added option to save images to cache (Not available for Web):
```dart
cacheAndroidIos: true, // or false
```

* Added option to change the fit of android and ios image. You can define it like this:
```dart
fitCarouselList: BoxFit.cover
```

* Added function to get click on the image:
```dart
onTap: () {
    debugPrint("©gabriel_patrick_souza");
},
```

## 1.0.0

* Initial release.
