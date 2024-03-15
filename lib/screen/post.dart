import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/modelPost.dart';
import 'package:detection/screen/community.dart';
import 'package:detection/screen/data.dart';
import 'package:detection/screen/home.dart';
import 'package:detection/screen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  PostController postController = PostController();
  TextEditingController questionC = TextEditingController();


  String? fileName;
  dynamic post;

  String? selectValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imagesUrls = [];
  @override
  void dispose() {
    // TODO: implement dispose
    images.clear();
    super.dispose();
    postController.dismiss();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask Community"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                child: GridView.builder(
                  primary: false,
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisSpacing: 3,crossAxisSpacing: 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(File(images[index].path),fit: BoxFit.fill,),
                    );
                  },),
              ),
              Card(
                color: Colors.green,
                child: ListTile(
                  onTap: ()async {
                    pickImages();
                  },
                  title: const Center(child: Text("Pick Image")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  controller: questionC,
                  decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    filled: true,
                    isDense: true,
                    hintText: "Enter question"
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: ListTile(
                  onTap: ()async {
                    save();
                  },
                  title: const Center(child: Text("Upload")),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  pickImages() async{
    final List<XFile> pick = await imagePicker.pickMultiImage();
    if(pick.isNotEmpty){
      setState(() {
        images.addAll(pick);
      });
    }else{
      print("Images not selected");
    }
  }

  Future postImages(XFile? imagesFile) async {
    String urls;
    Reference ref = FirebaseStorage.instance.ref().child("postImages").child(imagesFile!.name);
    await ref.putData(await imagesFile.readAsBytes(),
        SettableMetadata(contentType: "image/jpeg"));
    urls = await ref.getDownloadURL();
    return urls;
  }

  uploadImages() async{
    for(var image in images){
      await postImages(image).then((value) => imagesUrls.add(value));
    }
  }

  save() async {
    EasyLoading.show(status: "Shared...");
    await uploadImages();
    await FirebaseFirestore.instance.collection("post").add({
      "question" : questionC.text,
      "img" : imagesUrls,
      "comment" : "",
      "likeC" : [],
      "uid" : FirebaseAuth.instance.currentUser!.uid,
      "name" : FirebaseAuth.instance.currentUser!.displayName,
      "docId" : FirebaseFirestore.instance.collection("post").doc(),
      "messagesForward" : ""
    }).whenComplete(() {
      questionC.clear();
      Get.offAll(()=>const Home());
      EasyLoading.dismiss();
      setState(() {
        imagesUrls = [];
      });
    });
  }

}
