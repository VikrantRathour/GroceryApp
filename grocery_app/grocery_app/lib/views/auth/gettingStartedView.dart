import 'package:flutter/material.dart';

class GettingStartedView extends StatefulWidget {
  final Function openSignInWithNumberView;
  GettingStartedView({this.openSignInWithNumberView});

  @override
  _GettingStartedViewState createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF29C17E),
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 3 / 5,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 1 / 4),
              child: Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image(
                    image: AssetImage('assets/logo.jpg'), fit: BoxFit.cover),
              )),
            ),
            Center(
              child: Text(
                'Welcome to',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            Center(
              child: Text(
                'Vision',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: 25.0),
            InkWell(
              onTap: () {
                widget.openSignInWithNumberView();
              },
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Colors.white),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
