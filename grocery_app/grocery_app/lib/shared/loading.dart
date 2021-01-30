import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: MediaQuery.of(context).size.height * 3 / 4,
        child: Center(
          child: SpinKitRing(
            color: Theme.of(context).primaryColor,
            size: 200.0,
          ),
        ),
      ),
    );
  }
}
