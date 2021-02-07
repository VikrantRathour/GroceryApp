import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedItem {
  final String uid;
  final String productId;
  final String productName;
  final int price;
  final String storeId;
  final String storeName;
  final String image;

  OrderedItem(
      {this.uid,
      this.productId,
      this.productName,
      this.price,
      this.storeId,
      this.storeName,
      this.image});

  factory OrderedItem.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return OrderedItem(
        uid: snapshot.id,
        productId: data['productId'],
        productName: data['productName'],
        price: data['price'],
        storeId: data['storeId'],
        storeName: data['storeName'],
        image: data['image'] ?? 'img.jpg');
  }
}
