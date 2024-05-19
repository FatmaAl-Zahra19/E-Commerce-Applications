// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/controllers/profile_controller.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:e_commerce_app/widgets_common/custom_textfield.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<profilecontroller>();
    return bgWidet(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if imgurl and controller is empty
              data['imageUrl'] == "" && controller.profileimgpath.isEmpty
                  ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()

                  //if data is not empty but controller is empty
                  : data['imageUrl'] != "" && controller.profileimgpath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      :
                      //if data is empty put controller is not
                      Image.file(
                          File(controller.profileimgpath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeimg(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              Divider(),
              20.heightBox,
              customTextField(
                  controller: controller.namecontroller,
                  hint: nameHint,
                  title: name,
                  isPass: false),
              10.heightBox,
              customTextField(
                  controller: controller.oldpasscontroller,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true),
              10.heightBox,
              customTextField(
                  controller: controller.newpasscontroller,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true),
              20.heightBox,
              controller.isloading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isloading(true);

                            // if img is not seleted
                            if (controller.profileimgpath.value.isNotEmpty) {
                              await controller.uploadproimg();
                            } else {
                              controller.proimglink = data['imageUrl'];
                            }
                            // if old pass matches db
                            if (data['password'] ==
                                controller.oldpasscontroller.text) {
                              await controller.changeAuthpassword(
                                email: data['email'],
                                password: controller.oldpasscontroller.text,
                                newpassword: controller.namecontroller.text,
                              );
                              await controller.updatepro(
                                  imageUrl: controller.proimglink,
                                  name: controller.namecontroller.text,
                                  password: controller.newpasscontroller.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "wrong old password");
                              controller.isloading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(EdgeInsets.all(16))
              .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
