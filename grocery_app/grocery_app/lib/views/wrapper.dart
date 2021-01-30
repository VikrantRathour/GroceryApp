import 'package:flutter/material.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/views/auth/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/views/auth/new_user_details.dart';
import 'package:grocery_app/views/home/homePageView.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;

              if (userData.name == 'Full Name') {
                return NewUserDetails();
              } else {
                return HomePageView();
              }
            } else {
              return Authenticate();
            }
          });
    }
  }
}
