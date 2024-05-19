// ignore_for_file: must_be_immutable

import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/views/auth_screen/signup_screen.dart';
import 'package:e_commerce_app/views/home_screen/home.dart';
import 'package:e_commerce_app/widgets_common/applogo_widgit.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/widgets_common/custom_textfield.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   // var controller = Get.put(AuthController());
    return bgWidet(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _HeaderSection(),
                _LoginFormSection(),
                _SocialMediaSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (context.screenHeight * 0.1).heightBox,
        applogoWidget(),
        10.heightBox,
        "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
      ],
    );
  }
}

class _LoginFormSection extends StatelessWidget {
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customTextField(
            hint: emailHint,
            title: email,
            isPass: false,
            controller: controller.emailcontroller),
        customTextField(
            hint: passwordHint,
            title: password,
            isPass: true,
            controller: controller.passwordcontroller),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: forgetPass.text.make(),
          ),
        ),
        5.heightBox,
        ourButton(
            color: redColor,
            title: login,
            textColor: whiteColor,
            onPress: () async {
              await controller.loginMethod(context: context).then((value) {
                if (value != null) {
                  VxToast.show(context, msg: loggedin);
                  Get.offAll(() => const Home());
                }
              });
            }).box.width(context.screenWidth - 50).make(),
        5.heightBox,
        createNewAccount.text.color(fontGrey).make(),
        5.heightBox,
        ourButton(
          color: lightGolden,
          title: signup,
          textColor: redColor,
          onPress: () {
            Get.to(() => const SignupScreen());
          },
        ).box.width(context.screenWidth - 50).make(),
      ],
    )
        .box
        .white
        .rounded
        .padding(const EdgeInsets.all(16))
        .width(context.screenWidth - 70)
        .shadowSm
        .make();
  }
}

class _SocialMediaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.heightBox,
        loginWith.text.color(fontGrey).make(),
        5.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: lightGrey,
                radius: 25,
                child: Image.asset(
                  socialIconList[index],
                  width: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
