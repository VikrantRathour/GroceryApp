import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String categoryUid;
  final String name;
  final String image;

  Category({this.categoryUid, this.name, this.image});

  factory Category.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return Category(
        categoryUid: snapshot.id,
        name: data['name'],
        image: data['image'] ?? 'img.jpg');
  }
}
