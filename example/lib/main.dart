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
      "https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ImageNetwork(
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
          onLoading: const CircularProgressIndicator(
            color: Colors.indigoAccent,
          ),
          onError: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                content: Text("©gabrielpatricksouza"),
              ),
            );
            debugPrint("©gabriel_patrick_souza");
          },
        ),
      ),
    );
  }
}
