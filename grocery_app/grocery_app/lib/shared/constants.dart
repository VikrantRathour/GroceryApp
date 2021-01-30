import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white30,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0))
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white38, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0))
  ),
  hintStyle: TextStyle(
    color: Colors.white60
  )
);