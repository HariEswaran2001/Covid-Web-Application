import 'package:covidpat/view/selection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBzyhG1KPOiKr08LRo9TXI7KkZkF02UXQ8",
          authDomain: "covidtest-f41f3.firebaseapp.com",
          projectId: "covidtest-f41f3",
          storageBucket: "covidtest-f41f3.appspot.com",
          messagingSenderId: "88705835284",
          appId: "1:88705835284:web:b64235c646bcb5b1756201",
          measurementId: "G-HW0FW84C6C"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Selection());
  }
}
