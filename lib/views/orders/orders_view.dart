import 'package:flutter/material.dart';
import 'package:grocery_app/models/order.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/database.dart';
import 'package:grocery_app/shared/loading.dart';
import 'package:grocery_app/views/orders/orders_tile.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<OrderedItem>>(
        stream: DatabaseService(uid: user.uid).getUserOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text(
                  'No Active Orders',
                  style: TextStyle(fontSize: 30.0, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return OrderTile(
                  orderedItem: snapshot.data[index],
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
