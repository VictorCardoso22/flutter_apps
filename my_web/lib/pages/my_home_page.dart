// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      body: Wrap(
        spacing: 20,
        children: List.generate(20,
            (index) => Container(width: 20, height: 15, color: Colors.black12)),
      ),
    );
  }
}
