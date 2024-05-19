// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'package:e_commerce_app/consts/consts.dart';
//import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/views/home_screen/home.dart';
//import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/widgets_common/applogo_widgit.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:e_commerce_app/widgets_common/custom_textfield.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
//import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isChecked = false; // Initialize with a default value
  final AuthController _authController = Get.put(AuthController());

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidet(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: _nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: _emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: _passwordController,
                      isPass: true),
                  customTextField(
                      hint: passwordHint,
                      title: retypePassward,
                      controller: _passwordRetypeController,
                      isPass: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: redColor,
                        value: _isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            _isChecked = newValue!;
                          });
                        },
                      ),
                      10.heightBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: termAndCond,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              )),
                          TextSpan(
                              text: " &",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              )),
                        ])),
                      )
                    ],
                  ),
                  5.heightBox,
                  ourButton(
                    color: _isChecked ? redColor : lightGrey,
                    title: signup,
                    textColor: whiteColor,
                    onPress: () async {
                      if (_isChecked) {
                        try {
                          await _authController
                              .signupMethod(
                            context: context, // Pass the context here
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                              .then((value) {
                            return _authController.storeUserData(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text,
                            );
                          }).then((Value) {
                           // VxToast.show(context, msg: loggedin);
                            Get.to(() => const Home());
                          });
                        } catch (e) {
                          auth.signOut();
                          //VxToast.show(context, msg: e.toString());
                        }
                      }
                      
                    },
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  // warpping into gesture detector of velocity X
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: alreadyHaveAccount,
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          ),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Get.back();
                  }),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    ));
  }
}
