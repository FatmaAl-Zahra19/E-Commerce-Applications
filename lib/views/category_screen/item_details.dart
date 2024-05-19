// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/prodect_controller.dart';
import 'package:e_commerce_app/views/chat_screen/chat_screen.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
var controller = Get.put(ProductController());
    print(Colors.purple.value);
    return WillPopScope(
      onWillPop: () async {
        controller.resetvalue();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetvalue();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isfav.value) {
                      controller.removefromwishlist(data.id, context);
                      // controller.isfav(false);
                    } else {
                      controller.addtowishlist(data.id, context);
                      //controller.isfav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: controller.isfav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //swipwr section
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          itemCount: data['p-imgs'].length,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p-imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      // title and description
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      // rating
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p-rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p-price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,

                      20.heightBox,
                      //color section
                      Obx(
                        () => Column(
                          children: [
                            //quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decQuatity();
                                            controller.calctotalprice(
                                                int.parse(data['p-price']));
                                          },
                                          icon: Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increasQuatity(
                                                int.parse(data['p-quantity']));
                                            controller.calctotalprice(
                                                int.parse(data['p-price']));
                                          },
                                          icon: Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p-quantity']} available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),
                            //total

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Totel: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalprice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      //description
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p-desc']}".text.color(darkFontGrey).make(),


                      20.heightBox,

                      //
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: () {
                  if (controller.quantity.value > 0) {
                    controller.addtocart(
                        color: data['p-colors'][controller.colorindex.value],
                        context: context,
                        img: data['p-imgs'][0],
                        vendorid: data['vendor-id'],
                        qut: controller.quantity.value,
                        sellername: data['p-seller'],
                        title: data['p-name'],
                        tprice: controller.totalprice.value);
                    VxToast.show(context, msg: "Added to cart");
                  } else {
                    VxToast.show(context, msg: "Qyantity can't be 0, Minumum 1 product is required");
                  }
                },
                textColor: whiteColor,
                title: "Add To Cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
