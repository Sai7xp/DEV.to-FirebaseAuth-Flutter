
import 'package:firebase_gsignin/screens/splashscreen.dart';
import 'package:firebase_gsignin/screens/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FaceBase',
    routes: routes,
    home: SplashScreen(),
  ));
}
