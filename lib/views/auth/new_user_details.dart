import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/shared/constants.dart';
import 'package:grocery_app/views/home/homePageView.dart';

class NewUserDetails extends StatefulWidget {
  @override
  _NewUserDetailsState createState() => _NewUserDetailsState();
}

class _NewUserDetailsState extends State<NewUserDetails> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String location = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white24,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 20.0)
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0))),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Register',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 20.0)
                            ]),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Please Enter your name' : null,
                              onChanged: (val) {
                                setState(() => name = val);
                              },
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Full Name'),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 20.0)
                            ]),
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Please Enter Location' : null,
                              onChanged: (val) {
                                setState(() => location = val);
                              },
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Location'),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50.0))),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                            size: 35.0,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          DatabaseService(uid: user.uid)
                              .updateUserData(name, location, location);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomePageView()));
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
