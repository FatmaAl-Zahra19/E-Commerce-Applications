// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/controllers/profile_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/auth_screen/login_screen.dart';
import 'package:e_commerce_app/views/chat_screen/messaging_screen.dart';
import 'package:e_commerce_app/others_screen/orders_screen.dart';
import 'package:e_commerce_app/views/profile_screen/components/edit_profile_screen.dart';
import 'package:e_commerce_app/views/profile_screen/components/details_card.dart';
import 'package:e_commerce_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(profilecontroller());
    return bgWidet(
        child: Scaffold(
      body: StreamBuilder(
        stream: firestorServices.getuser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const // edit profile button
                        Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.edit, color: whiteColor),
                    ).onTap(() {
                      controller.namecontroller.text = data['name'];

                      Get.to(() => EditProfileScreen(
                            data: data,
                          ));
                    }),
                  ),
                  10.heightBox,
                  // users details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageUrl'] == ""
                            ? Image.asset(imgProfile2,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageUrl'],
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            "${data['email']}".text.white.make()
                          ],
                        )),
                        20.heightBox,
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                              color: whiteColor,
                            )),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child:
                                logout.text.fontFamily(semibold).white.make())
                      ],
                    ),
                  ),
                  20.heightBox,
                  FutureBuilder(
                      future: firestorServices.getcounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else {
                          print(snapshot.data);
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: countData[0].toString(),
                                  title: "in your cart",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[1].toString(),
                                  title: "your wishlist",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[2].toString(),
                                  title: "your orders",
                                  width: context.screenWidth / 3.4),
                            ],
                          );
                        }
                      }),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         count: data['cart_count'],
                  //         title: "in your cart",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['wishlist_count'],
                  //         title: "your wishlist",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['order_count'],
                  //         title: "your orders",
                  //         width: context.screenWidth / 3.4),
                  //   ],
                  // ),

                  20.heightBox,

                  // buttons section
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => MassegesScreen());
                              break;
                            default:
                          }
                        },
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonsList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
