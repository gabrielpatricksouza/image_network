## 2.4.1

* README Update
* Updated documentation

## 2.4.0

* Added option to enable or disable debug information
```dart
debugPrint: true,//or false
```

* Added option to use 100% of the image
```dart
fullScreen: true,//or false
```

## 2.3.0

* Added option to directly use CachedNetworkImage to cache images:
```dart
imageCache: CachedNetworkImageProvider(imageUrl)
```

* Removed cacheAndroidIos

## 2.2.0+1

* README Update

## 2.2.0

* Added option to display custom loading:
```dart
onLoading: const CircularProgressIndicator(
  color: Colors.indigoAccent,
),
```

* Added option to display custom error:
```dart
onError: const Icon(
  Icons.error,
  color: Colors.red,
),
```

## 2.1.0+1

* README Update

## 2.1.0

* Added option to embed BoxFit in Image for Android && Ios:
```dart
fitAndroidIos: BoxFit.cover,
```

* Added option to embed BoxFit in Image for Web:
```dart
fitWeb: BoxFitWeb.cover,
```

* Added option to insert border radius in Image:
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
