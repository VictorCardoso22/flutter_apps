// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:my_web/pages/my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
// ignore: use_key_in_widget_constructors
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // ignore: prefer_const_constructors, avoid_unnecessary_containers
          return MaterialApp(
            home: Text("Erro"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          // ignore: prefer_const_constructors
          return MyWeb();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        // ignore: prefer_const_constructors
        return CircularProgressIndicator();
      },
    );
  }
}

class MyWeb extends StatelessWidget {
  const MyWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Builder(builder: (context) {
      return MaterialApp(
        home: MyHomePage(),
      );
    });
  }
}
