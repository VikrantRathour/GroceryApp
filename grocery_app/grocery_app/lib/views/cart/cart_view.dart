import 'package:flutter/material.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/cart/cart_tile.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<CartItem>>(
        stream: DatabaseService(uid: user.uid).getUserCart(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return CartTile(
                  cartItem: snapshot.data[index],
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
