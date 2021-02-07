import 'package:flutter/material.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/home/cateories_list/category_tile.dart';

class CategoriesList extends StatelessWidget {
  final String currentLocation;
  CategoriesList({this.currentLocation});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: DatabaseService().getCategoriesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryTile(
                  category: snapshot.data[index],
                  currentLocation: currentLocation,
                );
              },
              shrinkWrap: true,
              itemCount: snapshot.data.length,
            );
          }
        });
  }
}
