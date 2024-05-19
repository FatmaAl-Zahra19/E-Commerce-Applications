import 'package:e_commerce_app/consts/consts.dart';

class firestorServices {
  //get users data
  static getuser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get procucts according to category

  static getproduct(category) {
    return firestore
        .collection(productsCollection)
        .where('p-category', isEqualTo: category)
        .snapshots();
  }

  //get cart
  static getcart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added-by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDoc(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getchatmsg(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p-wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getcounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added-by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p-wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allproducte() {
    return firestore.collection(productsCollection).snapshots();
  }

  static getsubcategoryproducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p-subcategory', isEqualTo: title)
        .snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return firestore
        .collection(productsCollection)
        .where('p-name', isLessThanOrEqualTo: title)
        .get();
  }
}
