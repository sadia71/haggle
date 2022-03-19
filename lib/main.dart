import 'package:flutter/material.dart';
import 'package:haggle/routes/HomePage.dart';
import 'package:haggle/routes/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;


    return MaterialApp(
        home: user?.uid != null ? const HomePage() : const LoginPage(),
        routes: user?.uid != null ? (<String, WidgetBuilder>{
          '/landingPage': (BuildContext context) => const MyApp(),
          '/homePage': (BuildContext context) => const HomePage(),
        }) :  (<String, WidgetBuilder>{
          '/landingPage': (BuildContext context) => const MyApp(),
          '/homePage': (BuildContext context) => const HomePage(),
        })
    );
  }
}