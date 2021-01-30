import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/stores/products_list/product_tile.dart';

class ProductsList extends StatefulWidget {
  final String storeId;

  const ProductsList({Key key, this.storeId}) : super(key: key);
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: DatabaseService().getProductsList(widget.storeId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ProductTile(
                product: snapshot.data[index],
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
