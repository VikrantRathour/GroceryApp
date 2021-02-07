import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_dashboard/models/category.dart';
import 'package:grocery_app_dashboard/services/database.dart';
import 'package:grocery_app_dashboard/shared/add_category_bottom_sheet.dart';

class AddProductView extends StatefulWidget {
  final String storeId;

  const AddProductView({Key key, this.storeId}) : super(key: key);
  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();

  String name;
  int price;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Product'),
        ),
        body: Column(
          children: [
            TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Please enter product name' : null,
              onChanged: (val) {
                setState(() => name = val);
              },
              decoration: InputDecoration(hintText: 'Product Name'),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              validator: (val) => (val.isEmpty ||
                      int.tryParse(val) <= 0 ||
                      int.tryParse(val) == null)
                  ? 'Please enter valid price'
                  : null,
              onChanged: (val) {
                setState(() => price = int.tryParse(val));
              },
              decoration: InputDecoration(hintText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                DatabaseService()
                    .addNewProductToStore(widget.storeId, name, price);
                Navigator.of(context).pop();
              }
            },
            child: Container(
              child: Center(
                  child: Text(
                'Add Product',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              )),
              height: 60.0,
            ),
          ),
        ),
      ),
    );
  }
}
