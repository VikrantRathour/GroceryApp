import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String storeId;
  final String name;
  final String location;
  final int distanceFromUser;

  Store({this.storeId, this.name, this.location, this.distanceFromUser});

  factory Store.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return Store(
        storeId: snapshot.id,
        name: data['name'],
        location: data['location'],
        distanceFromUser: data['distanceFromUser']);
  }
}
