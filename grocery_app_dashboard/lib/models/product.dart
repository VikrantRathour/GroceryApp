import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final int price;

  Product({this.name, this.price});

  factory Product.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return Product(name: data['name'], price: data['price']);
  }
}
