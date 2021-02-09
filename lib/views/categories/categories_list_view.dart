import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/views/categories/categores_list_builder.dart';

class CategoriesListView extends StatefulWidget {
  final String currentLocation;
  CategoriesListView({this.currentLocation});
  @override
  _CategoriesListViewState createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Categories',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: CategoriesListBuilder(
        currentLocation: widget.currentLocation,
      ),
    );
  }
}
