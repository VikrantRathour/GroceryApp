import 'package:flutter/material.dart';
import 'package:grocery_app/views/auth/signInWithNumberView.dart';
import 'package:grocery_app/views/auth/verifyNumber.dart';
import 'package:grocery_app/views/auth/gettingStartedView.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String currentView = '';
  String verificationId = '';

  void openSignInWithNumberView() {
    setState(() => currentView = 'SignInWithNumberView');
  }

  void openVerifyNumberView(String verId) {
    setState(() => currentView = 'VerifyNumber');
    setState(() => verificationId = verId);
  }

  @override
  Widget build(BuildContext context) {
    if (currentView == 'SignInWithNumberView') {
      return SignInWithNumberView(openVerifyNumberView: openVerifyNumberView);
    } else if (currentView == 'VerifyNumber') {
      return VerifyNumber(verificationId: verificationId);
    } else {
      return GettingStartedView(
          openSignInWithNumberView: openSignInWithNumberView);
    }
  }
}
