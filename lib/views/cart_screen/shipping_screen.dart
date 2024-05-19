import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/views/cart_screen/payment_method.dart';
import 'package:e_commerce_app/widgets_common/custom_textfield.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final _cartController = Get.find<cartcontroller>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(
                  hint: "Address",
                  isPass: false,
                  title: "Address",
                  controller: _cartController.addresscontroller),
              customTextField(
                  hint: "City",
                  isPass: false,
                  title: "City",
                  controller: _cartController.citycontroller),
              customTextField(
                  hint: "State",
                  isPass: false,
                  title: "State",
                  controller: _cartController.statecontroller),
              customTextField(
                  hint: "Postal Code",
                  isPass: false,
                  title: "Postal Code",
                  controller: _cartController.postlcodecontroller),
              customTextField(
                  hint: "Phone",
                  isPass: false,
                  title: "Phone",
                  controller: _cartController.phonecontroller),
              _ContinueButton(cartController: _cartController),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final cartcontroller cartController;

  const _ContinueButton({required this.cartController, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ourButton(
        onPress: () {
          if (cartController.addresscontroller.text.length > 10) {
            Get.to(() => const Classify()/*Classify()*/);
          } else {
            VxToast.show(context, msg: "Please fill the form");
          }
        },
        color: redColor,
        textColor: whiteColor,
        title: "Continue",
      ),
    );
  }
}
