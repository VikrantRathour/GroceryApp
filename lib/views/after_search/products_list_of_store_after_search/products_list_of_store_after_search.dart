import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/stores/products_list/product_tile.dart';

class ProductsListOfStoreAfterSearch extends StatefulWidget {
  final Store store;

  const ProductsListOfStoreAfterSearch({this.store});
  @override
  _ProductsListOfStoreAfterSearchState createState() =>
      _ProductsListOfStoreAfterSearchState();
}

class _ProductsListOfStoreAfterSearchState
    extends State<ProductsListOfStoreAfterSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Available'),
      ),
      body: StreamBuilder<List<Product>>(
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
              scrollDirection: Axis.vertical,
            );
          }
        },
      ),
    );
  }
}
