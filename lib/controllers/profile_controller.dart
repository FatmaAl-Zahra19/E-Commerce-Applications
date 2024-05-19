import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class profilecontroller extends GetxController {
  var profileimgpath = ''.obs;
  var namecontroller = TextEditingController();
  var oldpasscontroller = TextEditingController();
  var newpasscontroller = TextEditingController();

  var proimglink = "";
  var isloading = false.obs;
  changeimg(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileimgpath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadproimg() async {
    var filename = basename(profileimgpath.value);
    var dist = "images/${currentUser!.uid}/$filename";
    Reference ref = FirebaseStorage.instance.ref().child(dist);
    await ref.putFile(File(profileimgpath.value));
    proimglink = await ref.getDownloadURL();
  }

  updatepro({name, password, imageUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));
    isloading(false);
  }

  changeAuthpassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      print(error.toString());
    });
  }
}
