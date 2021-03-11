import 'package:cloud_firestore/cloud_firestore.dart';

class OrderedItem {
  final String uid;
  final String productId;
  final String productName;
  final int price;
  final String storeId;
  final String storeName;
  final String image;
  final int time;

  OrderedItem(
      {this.uid,
      this.productId,
      this.productName,
      this.price,
      this.storeId,
      this.storeName,
      this.image,
      this.time});

  factory OrderedItem.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    var timeDiff =
        data['createdOn'].toDate().difference(DateTime.now()).inMinutes;
    return OrderedItem(
        uid: snapshot.id,
        productId: data['productId'],
        productName: data['productName'],
        price: data['price'],
        storeId: data['storeId'],
        storeName: data['storeName'],
        image: data['image'] ?? 'img.jpg',
        time: timeDiff);
  }
}
