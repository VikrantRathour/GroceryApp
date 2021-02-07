import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String uid;
  final String name;
  final int price;
  final String image;

  Product({this.uid, this.name, this.price, this.image});

  factory Product.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return Product(
        uid: snapshot.id,
        name: data['name'],
        price: data['price'],
        image: data['image'] ?? 'img.jpg');
  }
}
