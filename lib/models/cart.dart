import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String uid;
  final String productId;
  final String productName;
  final int price;
  final String storeId;
  final String storeName;
  final String image;

  CartItem(
      {this.uid,
      this.productId,
      this.productName,
      this.price,
      this.storeId,
      this.storeName,
      this.image});

  factory CartItem.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return CartItem(
        uid: snapshot.id,
        productId: data['productId'],
        productName: data['productName'],
        price: data['price'],
        storeId: data['storeId'],
        storeName: data['storeName'],
        image: data['image'] ?? 'img.jpg');
  }
}
