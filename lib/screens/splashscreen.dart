import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gsignin/screens/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  navigateUser() {
    // checking whether user already loggedIn or not
    FirebaseAuth.instance.currentUser().then((currentUser) {
      if (currentUser == null) {
        Timer(Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(context, "/auth"));
      } else {
        Timer(
          Duration(seconds: 2),
          () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(username: currentUser.displayName)),
              (Route<dynamic> route) => false),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("Design Your splash screen"),
        ),
      ),
    );
  }
}
