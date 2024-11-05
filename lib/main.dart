import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('com.taebbong.chungMo.share_intent');
  String? sharedText;

  @override
  void initState() {
    super.initState();
    _getSharedData();
  }

  Future<void> _getSharedData() async {
    try {
      final result = await platform.invokeMethod<String>('getSharedData');
      setState(() {
        print(result);
        sharedText = result;
      });
    } on PlatformException catch (e) {
      print("Failed to get shared data: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shared Data")),
      body: Center(
        child: Text(sharedText ?? 'No shared content received'),
      ),
    );
  }
}
