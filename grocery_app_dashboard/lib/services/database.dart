import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app_dashboard/models/category.dart';
import 'package:grocery_app_dashboard/models/product.dart';
import 'package:grocery_app_dashboard/models/store.dart';

class DatabaseService {
  final CollectionReference storesCollection =
      FirebaseFirestore.instance.collection('stores');

  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  Future addNewStore(
      String storeName, String location, int distanceFromUser) async {
    await storesCollection.add({
      'name': storeName,
      'location': location,
      'distanceFromUser': distanceFromUser
    });
  }

  Stream<List<Store>> getStoresList() {
    return storesCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => Store.fromMap(doc)).toList());
  }

  Future addNewProductToStore(
      String storeId, String productName, int price, String category) async {
    await storesCollection
        .doc(storeId)
        .collection('products')
        .add({'name': productName, 'price': price, 'category': category});
  }

  Stream<List<Product>> getProductsList(String storeId) {
    return storesCollection
        .doc(storeId)
        .collection('products')
        .snapshots()
        .map((list) => list.docs.map((doc) => Product.fromMap(doc)).toList());
  }

  Future addNewCategory(String categoryName) async {
    await categoriesCollection.add({'name': categoryName});
  }

  Stream<List<Category>> getCategoriesList() {
    return categoriesCollection
        .snapshots()
        .map((list) => list.docs.map((doc) => Category.fromMap(doc)).toList());
  }
}
