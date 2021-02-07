import 'package:flutter/material.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/home/stores_list/store_tile.dart';

class StoresList extends StatelessWidget {
  final String currentLocation;
  StoresList({this.currentLocation});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Store>>(
      stream: DatabaseService().getStoresList(currentLocation),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return StoreTile(
                store: snapshot.data[index],
              );
            },
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            physics: NeverScrollableScrollPhysics(),
          );
        }
      },
    );
  }
}
