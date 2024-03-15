import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/screen/community.dart';
import 'package:detection/screen/data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../screen/home.dart';
import '../screen/homeScreen.dart';

class PostController extends GetxController {


  File? image;
  String? url;
  var questionController = TextEditingController();

  //dynamic image;
  String? fileName;
  dynamic post;

  String? selectValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imagesUrls = [];

    uploadData() async{
      try{
        EasyLoading.show(status: "Shared...");
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("post").child(Uuid().v1()).putFile(image!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downLoadurl = await taskSnapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance.collection("post").doc().set({
          "question" : questionController.text.toString(),
          "img" : downLoadurl,
          "comment" : "",
          "likeC" : [],
          "uid" : FirebaseAuth.instance.currentUser!.uid,
          "name" : FirebaseAuth.instance.currentUser!.displayName,
          "docId" : FirebaseFirestore.instance.collection("post").doc().id,
          "messagesForward" : ""
        }).whenComplete(() {
          Get.offAll(()=>const Home());
          EasyLoading.dismiss();
        });
      }catch(e){
        EasyLoading.dismiss();
      }
    }

    void dismiss(){
    questionController.clear();
    image = null;
    url = null;
    }

    updateData(){

    }


  // pickImages() async{
  //   final List<XFile> pick = await imagePicker.pickMultiImage();
  //   if(pick.isNotEmpty){
  //     setState(() {
  //       images.addAll(pick);
  //     });
  //   }else{
  //     print("Images not selected");
  //   }
  // }
  //
  // Future postImages(XFile? imagesFile) async {
  //   String urls;
  //   Reference ref = FirebaseStorage.instance.ref().child("postImages").child(imagesFile!.name);
  //   await ref.putData(await imagesFile.readAsBytes(),
  //       SettableMetadata(contentType: "image/jpeg"));
  //   urls = await ref.getDownloadURL();
  //   return urls;
  // }
  //
  // uploadImages() async{
  //   for(var image in images){
  //     await postImages(image).then((value) => imagesUrls.add(value));
  //   }
  // }
  //
  // save() async {
  //   await uploadImages();
  //   await FirebaseFirestore.instance.collection("products").add({
  //     "images" : imagesUrls,
  //     "categoriesName" : widget.data["categoriesName"],
  //     "pName" : nameController.text,
  //     "description" : desController.text,
  //     "price" : priceController.text,
  //     "discount" : discountController.text,
  //     "popular" : popular,
  //     "uid" : "",
  //     "messages" : "",
  //     "id" : ""
  //   }).whenComplete(() {
  //     nameController.clear();
  //     desController.clear();
  //     priceController.clear();
  //     discountController.clear();
  //     setState(() {
  //       imagesUrls = [];
  //       popular = false;
  //     });
  //   });
  // }


}