import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String location;

  Location({this.location});

  factory Location.fromMap(DocumentSnapshot snapshot) {
    final data = snapshot.data();

    return Location(location: data['name'] ?? 'NA');
  }
}
