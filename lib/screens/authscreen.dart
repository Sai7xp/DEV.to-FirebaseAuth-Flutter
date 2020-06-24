import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_gsignin/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

String name;
String email;
String imageUrl;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isVisible = false;
  Future<FirebaseUser> _signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication gsa =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: gsa.idToken,
      accessToken: gsa.accessToken,
    );
    final AuthResult authResult = await auth.signInWithCredential(credential);
    final FirebaseUser firebaseUser = authResult.user;
    name = firebaseUser.displayName;
    email = firebaseUser.email;
    imageUrl = firebaseUser.photoUrl;
    final FirebaseUser currentUser = await auth.currentUser();
    assert(firebaseUser.uid == currentUser.uid);
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    var swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB2F2D52)),
                ),
                visible: isVisible,
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 60.0,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 54.0,
                width: swidth / 1.45,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      this.isVisible = true;
                    });
                    _signIn().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(username: name)),
                          (Route<dynamic> route) => false);
                    }).catchError((onError) {
                      Navigator.pushReplacementNamed(context, "/auth");
                    });
                  },
                  child: Text(
                    ' Continue With Google',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  elevation: 5,
                  color: Color(0XFFF7C88C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
