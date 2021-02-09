import 'package:flutter/material.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/all_category_detail/store_tile_for_all_category.dart';

class StoresListForAllCategory extends StatefulWidget {
  final String category;

  const StoresListForAllCategory({this.category});
  @override
  _StoresListForAllCategoryState createState() =>
      _StoresListForAllCategoryState();
}

class _StoresListForAllCategoryState extends State<StoresListForAllCategory> {
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
        stream: DatabaseService().getStoresByCategory(widget.category),
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
                return StoreTileForAllCategory(
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
