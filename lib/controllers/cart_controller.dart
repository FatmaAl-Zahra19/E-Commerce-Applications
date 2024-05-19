import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class cartcontroller extends GetxController {
  var totalp = 0.obs;

  var addresscontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var postlcodecontroller = TextEditingController();
  var paymentIndex = 0.obs;
  late dynamic productsnapshot;
  var products = [];
  var placingorder = false.obs;
  calculatep(data) {
    totalp.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalp.value = totalp.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changepaymentindex(index) {
    paymentIndex.value = index;
  }

  placemyorder({required orderpaymentmethod, required totalamount}) async {
    placingorder(true);
    await getproductsDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code':"4288423856",
      'order_date':FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addresscontroller.text,
      'order_by_state': statecontroller.text,
      'order_by_city': citycontroller.text,
      'order_by_phone': phonecontroller.text,
      'order_by_postalcode': postlcodecontroller.text,
     // 'order_code':,
      'shipping_method': "Home Delivery",
      'payment_method': orderpaymentmethod,
      'order_placed': true,
      'order_confirm': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalamount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingorder(false);
  }

  getproductsDetails() {
    products.clear();
    for (var i = 0; i < productsnapshot.length; i++) {
      products.add({
        'color': productsnapshot[i]['color'],
        'img': productsnapshot[i]['img'],
        'vendor-id': productsnapshot[i]['vendor-id'],
        'tprice': productsnapshot[i]['tprice'],
        'qut': productsnapshot[i]['qut'],
        'title': productsnapshot[i]['title'],
      });
    }
  }

  clearcart() {
    for (var i = 0; i < productsnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productsnapshot[i].id).delete();
    }
  }
}
