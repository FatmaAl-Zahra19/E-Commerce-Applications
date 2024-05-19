import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/firebase_consts.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorindex = 0.obs;
  var totalprice = 0.obs;

  var isfav = false.obs;
  getsubcategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/caregory_model.json");
    // ignore: unused_local_variable
    var decoded = caregorymodelFromJson(data);
    var s = decoded.category.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changrcolor(index) {
    colorindex = index;
  }

  increasQuatity(totalquantity) {
    if (quantity.value < totalquantity) {
      quantity.value++;
    }
  }

  decQuatity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calctotalprice(price) {
    totalprice.value = price * quantity.value;
  }

  addtocart({title, img, sellername, color, qut, tprice, context,vendorid}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'vendor-id':vendorid,
      'color': color,
      'qut': qut,
      'tprice': tprice,
      'added-by': currentUser!.uid
    }).catchError((Error) {
      VxToast.show(context, msg: Error.toString());
    });
  }

  resetvalue() {
    totalprice.value = 0;
    quantity.value = 0;
    colorindex.value = 0;
  }

  addtowishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p-wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removefromwishlist(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p-wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isfav(false);
        VxToast.show(context, msg: "remove from Wishlist");

  }

  checkiffav(data) async {
    if (data['p-wishlist'].contains(currentUser!.uid)) {
      isfav(true);
    } else {
      isfav(false);
    }
  }
}
