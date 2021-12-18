import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageNetwork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo ImageNetwork'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String imageUrl =
      "https://scaffoldtecnologia.com.br/wp-content/uploads/2021/10/app-2.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ImageNetwork(
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
        ),
      ),
    );
  }
}
