import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/store.dart';
import 'package:grocery_app/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference storesCollection =
      FirebaseFirestore.instance.collection('stores');

  Future<UserData> get userModelObject async {
    return await usersCollection.doc(uid).get().then((value) {
      return UserData(
          name: value.data()['name'] ?? '',
          address: value.data()['address'] ?? '',
          location: value.data()['location'] ?? '');
    });
  }

  Future updateUserData(String name, String address, String location) async {
    return await usersCollection
        .doc(uid)
        .set({'name': name, 'address': address, 'location': location});
  }

  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'] ?? 'No Name',
        address: snapshot.data()['address'] ?? 'No Address',
        location: snapshot.data()['location'] ?? 'No Location');
  }

  Stream<List<Store>> getStoresList() {
    return storesCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => Store.fromMap(doc)).toList());
  }

  Stream<List<Product>> getProductsList(String storeId) {
    return storesCollection
        .doc(storeId)
        .collection('products')
        .snapshots()
        .map((list) => list.docs.map((doc) => Product.fromMap(doc)).toList());
  }
}
