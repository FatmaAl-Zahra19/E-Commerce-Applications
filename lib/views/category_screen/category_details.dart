// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controllers/prodect_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/category_screen/item_details.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
//import 'package:flutter/material.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  //late final String? title;
  @override
  void initState() {
    super.initState();
    swichcat(widget.title);
  }

  swichcat(title) {
    if (controller.subcat.contains(title)) {
      productMethod = firestorServices.getsubcategoryproducts(title);
    } else {
      productMethod = firestorServices.getproduct(title);
    }
  }

  // var controller = Get.find<ProductController>();
  var controller = Get.put(ProductController());

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidet(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   physics: const BouncingScrollPhysics(),
            //   child: Row(
            //     children: List.generate(
            //         controller.subcat.length,
            //         (index) => "${controller.subcat[index]}"
            //                 .text
            //                 .size(12)
            //                 .fontFamily(semibold)
            //                 .color(whiteColor)
            //                 .makeCentered()
            //                 .box
            //                 .white
            //                 .rounded
            //                 .size(120, 60)
            //                 .margin(const EdgeInsets.symmetric(horizontal: 4))
            //                 .make()
            //                 .onTap(() {
            //               swichcat("${controller.subcat[index]}");
            //               setState(() {});
            //             })),
            //   ),
            // ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: "No Product Found!"
                        .text
                        .color(darkFontGrey)
                        .makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p-imgs'][0],
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              "${data[index]['p-name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${data[index]['p-price']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowSm
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            controller.checkiffav(data[index]);
                            Get.to(() => ItemDetails(
                                title: "${data[index]['p-name']}",
                                data: data[index]));
                          });
                        }),
                  );
                  //   ],
                  // );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
