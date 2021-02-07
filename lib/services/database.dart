import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/location.dart';
import 'package:grocery_app/models/order.dart';
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
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference locationsCollection =
      FirebaseFirestore.instance.collection('locations');

  Future<UserData> get userModelObject async {
    return await usersCollection.doc(uid).get().then((value) {
      return UserData(
          name: value.data()['name'] ?? '',
          address: value.data()['address'] ?? '',
          location: value.data()['location'] ?? '');
    });
  }

  Future updateUserData(String name, String location) async {
    return await usersCollection
        .doc(uid)
        .set({'name': name, 'location': location});
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

  Stream<List<Store>> getStoresList(String currentLocation) {
    return storesCollection
        .where('location', isEqualTo: currentLocation)
        .snapshots()
        .map((list) => list.docs.map((doc) => Store.fromMap(doc)).toList());
  }

  Stream<List<Store>> getStoresByCategory(String category, String location) {
    return storesCollection
        .where('category', isEqualTo: category)
        .where('location', isEqualTo: location)
        .snapshots()
        .map((list) => list.docs.map((doc) => Store.fromMap(doc)).toList());
  }

  Future<String> getUserName() async {
    return await usersCollection
        .doc(uid)
        .get()
        .then((doc) => doc.data()['name']);
  }

  Future<Iterable<Store>> getStoreWithCategorySearched(
      String searchedValue) async {
    return await storesCollection
        // .orderBy('category', descending: false)
        .orderBy('name', descending: false)
        .startAt([searchedValue])
        .endAt([searchedValue + '\uf8ff'])
        // .where('name', isGreaterThanOrEqualTo: searchedValue)
        // .where('category', isEqualTo: searchedValue)
        .get()
        .then((list) => list.docs
            // .where((snapshot) => snapshot.data().containsValue(searchedValue))
            .map((doc) => Store.fromMap(doc)));
  }

  Stream<List<Product>> getProductsList(String storeId) {
    return storesCollection
        .doc(storeId)
        .collection('products')
        .snapshots()
        .map((list) => list.docs.map((doc) => Product.fromMap(doc)).toList());
  }

  Stream<List<Category>> getCategoriesList() {
    return categoriesCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => Category.fromMap(doc)).toList());
  }

  Stream<List<CartItem>> getUserCart() {
    return usersCollection
        .doc(uid)
        .collection('cart')
        .snapshots()
        .map((list) => list.docs.map((doc) => CartItem.fromMap(doc)).toList());
  }

  Stream<List<OrderedItem>> getUserOrders() {
    return usersCollection.doc(uid).collection('orders').snapshots().map(
        (list) => list.docs.map((doc) => OrderedItem.fromMap(doc)).toList());
  }

  Stream<List<Location>> getLocations() {
    return locationsCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => Location.fromMap(doc)).toList());
  }

  Future addItemToCart(String productId, String productName, int productPrice,
      Store store) async {
    await usersCollection.doc(uid).collection('cart').add({
      'productId': productId,
      'productName': productName,
      'price': productPrice,
      'storeId': store.storeId,
      'storeName': store.name,
      'image': store.image,
      'createdOn': DateTime.now()
    });
  }

  Future orderItem(String productId, String productName, int productPrice,
      String productImage, Store store) async {
    await usersCollection.doc(uid).collection('orders').add({
      'productId': productId,
      'productName': productName,
      'price': productPrice,
      'storeId': store.storeId,
      'storeName': store.name,
      'image': productImage,
      'createdOn': DateTime.now()
    });
  }

  Future removeProductFromCart(String cartItemUid) async {
    await usersCollection.doc(uid).collection('cart').doc(cartItemUid).delete();
  }
}
