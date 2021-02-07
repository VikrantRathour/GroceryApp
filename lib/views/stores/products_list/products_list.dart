import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/stores/products_list/product_tile.dart';

class ProductsList extends StatefulWidget {
  final Store store;

  const ProductsList({this.store});
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: DatabaseService().getProductsList(widget.store.storeId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ProductTile(
                product: snapshot.data[index],
                store: widget.store,
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
