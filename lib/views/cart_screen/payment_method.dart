import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/views/home_screen/home.dart';
import 'package:e_commerce_app/widgets_common/loading_indicator.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Classify extends StatefulWidget {
  const Classify({super.key});

  @override
  State<Classify> createState() => _ClassifyState();
}

class _ClassifyState extends State<Classify> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<cartcontroller>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        toolbarHeight: 60.2,
        toolbarOpacity: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
        ),
        title: Text(
          'Make your request for',
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Merriweather'),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Centered buttons with styled container
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // const RequestBaby()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whiteColor, // Background color
                      foregroundColor: Colors.white,
                      fixedSize: const Size(170, 65), // Text color
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'For Baby',
                      style: const TextStyle(fontSize: 27),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      controller.placemyorder(
                          orderpaymentmethod:
                              paymentMethodslist[controller.paymentIndex.value],
                          totalamount:
                              controller.totalp.value); //RequestAdult()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whiteColor, // Background color
                      foregroundColor: Colors.white,
                      fixedSize: const Size(170, 65), // Text color
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'For Adult',
                      style: const TextStyle(fontSize: 27),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class PaymentMethods extends StatelessWidget {
//   const PaymentMethods({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<cartcontroller>();
//     return Obx(
//       () => Scaffold(
//         backgroundColor: whiteColor,
//         bottomNavigationBar: SizedBox(
//           height: 60,
//           child: controller.placingorder.value
//               ? Center(
//                   child: loadingIndicator(),
//                 )
//               : ourButton(
//                   onPress: () async {
//                     await controller.placemyorder(
//                         orderpaymentmethod:
//                             paymentMethodslist[controller.paymentIndex.value],
//                         totalamount: controller.totalp.value);

//                     await controller.clearcart();
//                     VxToast.show(context, msg: "Order place successfuly");
//                     Get.offAll(const Home());
//                   },
//                   color: redColor,
//                   textColor: whiteColor,
//                   title: "Place my order",
//                 ),
//         ),
//         appBar: AppBar(
//           title: "Choose payment mathod"
//               .text
//               .fontFamily(semibold)
//               .color(darkFontGrey)
//               .size(20)
//               .make(),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Obx(
//             () => SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min, // add this
//                 children: List.generate(paymentMethodsimg.length, (index) {
//                   return GestureDetector(
//                     onTap: () {
//                       controller.changepaymentindex(index);
//                     },
//                     child: Container(
//                       //clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: controller.paymentIndex.value == index
//                                 ? redColor
//                                 : Colors.transparent,
//                             width: 4,
//                           )),
//                       margin: const EdgeInsets.only(bottom: 8),
//                       child: Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           SizedBox(
//                             // add this
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width, // bounded width
//                             height: 120,
//                             child: Image.asset(
//                               paymentMethodsimg[index],
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           controller.paymentIndex.value == index
//                               ? Transform.scale(
//                                   scale: 1.3,
//                                   child: Checkbox(
//                                       activeColor: Colors.blueGrey,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       value: true,
//                                       onChanged: ((value) {})),
//                                 )
//                               : Container(),
//                           Stack(
//                             children: [
//                               Positioned(
//                                   bottom: 10,
//                                   right: 10,
//                                   child: paymentMethodslist[index]
//                                       .text
//                                       .white
//                                       .fontFamily(semibold)
//                                       .size(16)
//                                       .make()),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
