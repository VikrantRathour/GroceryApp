import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/views/home/home_page_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF29C17E), accentColor: Color(0xFF1C8244)),
    );
  }
}
