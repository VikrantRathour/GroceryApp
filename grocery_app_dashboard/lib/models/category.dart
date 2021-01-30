import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;

  Category({this.name});

  factory Category.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return Category(name: data['name']);
  }
}
