import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_gsignin/screens/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  @override
  void initState() {
    super.initState();
    startTime();
    navigateUser();
  }

  Future startTime() async {
    await Firebase.initializeApp();
    final User firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser.reload();
    // get User authentication status here
    _user = _auth.currentUser;
  }

  navigateUser() async {
    // checking whether user already loggedIn or not

    if (_user != null) {
      Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => HomeScreen(username: _user.displayName)),
            (Route<dynamic> route) => false),
      );
    } else {
      Timer(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, "/auth"));
    }
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
