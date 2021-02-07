import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/shared/loading.dart';

class SignInWithNumberView extends StatefulWidget {
  final Function openVerifyNumberView;
  SignInWithNumberView({this.openVerifyNumberView});

  @override
  _SignInWithNumberViewState createState() => _SignInWithNumberViewState();
}

class _SignInWithNumberViewState extends State<SignInWithNumberView> {
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool canVerifyManually = false;
  bool loading = false;

  String phoneNumber = '';
  String verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF29C17E),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
        child: loading
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Loading(),
                Column(
                  children: [
                    Text(
                        'Please wait... Your mobile number will be verified automatically or:'),
                    SizedBox(height: 25.0),
                    Container(
                        child: canVerifyManually
                            ? InkWell(
                                onTap: () async {
                                  widget.openVerifyNumberView(verificationId);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFF29C17E)),
                                  child: Text(
                                    'Enter OTP Manually',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 45.0,
                              )),
                  ],
                ),
              ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's your number",
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Enter mobile number to continue',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (val) => val.length < 10 || val.length > 10
                              ? 'Please Enter a valid mobile number'
                              : null,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() => phoneNumber = val);
                          },
                          decoration:
                              InputDecoration(hintText: 'Your mobile number'),
                        ),
                        SizedBox(height: 25.0),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              signInWithPhoneNumber(phoneNumber);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFF29C17E)),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future signInWithPhoneNumber(String phoneNumber) async {
    try {
      final PhoneVerificationCompleted verified =
          (PhoneAuthCredential credential) async {
        await _auth.signIn(credential);
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException ex) {
        if (ex.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        print(ex.code);
      };

      final PhoneCodeSent codeSent = (String verId, int resendToken) {
        print('codeSent');

        setState(() => canVerifyManually = true);
        setState(() => verificationId = verId);
      };

      final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout =
          (String verId) {
        print('codeAutoRetrievalTimeout');
      };

      await _authFirebase.verifyPhoneNumber(
          phoneNumber: '+91' + phoneNumber,
          verificationCompleted: verified,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          // timeout: const Duration(seconds: 30),
          codeAutoRetrievalTimeout: autoRetrievalTimeout);
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
