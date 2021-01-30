import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/models/store.dart';
import 'package:grocery_app_dashboard/services/database.dart';
import 'package:grocery_app_dashboard/shared/loading.dart';
import 'package:grocery_app_dashboard/views/home/stores_list/store_tile.dart';

class StoresList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Store>>(
      stream: DatabaseService().getStoresList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return StoreTile(
                store: snapshot.data[index],
              );
            },
            shrinkWrap: true,
            itemCount: snapshot.data.length,
          );
        }
      },
    );
  }
}
