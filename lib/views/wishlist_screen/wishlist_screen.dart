// ignore_for_file: unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(regular).make(),
      ),
      body: StreamBuilder(
          stream: firestorServices.getWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No orders yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      '${data[index]['p-imgs'][0]}',
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: "${data[index]['p-name']}"
                        .text
                        .fontFamily(semibold)
                        .size(16)
                        .make(),
                    subtitle: "${data[index]['p-price']}"
                        .numCurrency
                        .text
                        .size(16)
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(
                      Icons.favorite,
                      color: redColor,
                    ).onTap(() async {
                      await firestore
                          .collection(productsCollection)
                          .doc(data[index].id)
                          .set({
                        'p-wishlist': FieldValue.arrayRemove([currentUser!.uid])
                      }, SetOptions(merge: true));
                    }),
                  );
                },
              );
            }
          }),
    );
  }
}
