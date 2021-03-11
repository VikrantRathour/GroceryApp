import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/views/home/homePageView.dart';
import 'package:grocery_app/views/orders/order_summary.dart';
import 'package:grocery_app/views/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/services/auth.dart';
import 'package:grocery_app/models/user.dart';
import 'package:firebase_core/firebase_core.dart';

import 'shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: MaterialApp(
              home: Loading(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Color(0xFF29C17E),
                  accentColor: Color(0xFF1C8244)),
            ),
          );
        }
        if (snapshot.data is User && snapshot.data != null) {
          return StreamProvider<CustomUserModel>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: HomePageView(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Color(0xFF29C17E),
                accentColor: Color(0xFF1C8244),
              ),
            ),
          );
        }
        return StreamProvider<CustomUserModel>.value(
          value: AuthService().user,
          child: MaterialApp(
            home: Wrapper(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Color(0xFF29C17E),
                accentColor: Color(0xFF1C8244)),
          ),
        );
      },
    );
  }
}
