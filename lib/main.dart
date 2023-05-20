
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:women_safety/pages/alert.dart';
import 'pages/loginpage.dart';
import 'pages/homepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheSecure',
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0)),

      home: LoginPage());
  }
}
