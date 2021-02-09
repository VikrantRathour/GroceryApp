import 'package:flutter/material.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/category_detail/store_tile_for_category.dart';

class StoresListForCategory extends StatefulWidget {
  final String category;
  final String currentLocation;

  const StoresListForCategory({this.category, this.currentLocation});
  @override
  _StoresListForCategoryState createState() => _StoresListForCategoryState();
}

class _StoresListForCategoryState extends State<StoresListForCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category}',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<Store>>(
        stream: DatabaseService().getStoresByCategoryAndLocation(
            widget.category, widget.currentLocation),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else if (snapshot.data.length <= 0) {
            return Center(
              child: Text('No stores available'),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return StoreTileForCategory(
                  store: snapshot.data[index],
                );
              },
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              physics: ClampingScrollPhysics(),
            );
          }
        },
      ),
    );
  }
}
