import 'package:flutter/material.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/shared/loading.dart';

class VerifyNumber extends StatefulWidget {
  final String verificationId;
  VerifyNumber({this.verificationId});

  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final _fromKey = GlobalKey<FormState>();
  String otp = '';
  String error = '';
  bool loading = false;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.white,
            child: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFF29C17E),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Form(
              key: _fromKey,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify your number",
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '6 digit code sent to your number',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                (val.length < 6 || val.length > 6)
                                    ? 'Please Enter a valid OTP'
                                    : null,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() => otp = val);
                            },
                            decoration:
                                InputDecoration(hintText: 'Enter OTP here'),
                          ),
                          SizedBox(height: 15.0),
                          InkWell(
                              onTap: () {
                                if (_fromKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result = _auth.signInWithOtp(
                                      otp, widget.verificationId);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Invalid OTP';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 45.0,
                                  width: 95.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFF29C17E)),
                                  child: Text(
                                    'VERIFY',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
