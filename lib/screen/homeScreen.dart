import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tflite_v2/tflite_v2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  List? _result;
  bool imageSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
    _image = null;
    _result = null;
    imageSelected = false;
  }

  // Tflite method...

  Future loadModel() async {
      String? res = await Tflite.loadModel(
        labels: "ass/labels2.txt",
        model: "ass/model_unquant2.tflite",
      );
      print(res);
  }

  // Future loadModel() async {
  //   String? res = await Tflite.loadModel(
  //     labels: "ass/models/labels2.txt",
  //     model: "ass/models/model_unquant2.tflite",
  //   );
  //   // tf.lite.TFLiteConverter.from_saved_model(saved_model_dir)
  //   print(res);
  //   //Tflite.close();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Take a Picture")),
      body: ListView(
        children: [
          (imageSelected)
              ? Container(
                  height: Get.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  child: Image.file(_image!, fit: BoxFit.cover),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: Opacity(
                    opacity: 0.9,
                    child: Container(
                      height: Get.height * 0.3,
                      color: Colors.green.shade200,
                      child: Center(
                        child: Column(
                          children: [
                            Lottie.asset('lottie/upload.json',height: Get.height*0.26),
                            const Text("Upload The Image")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          Column(
              children: (imageSelected)
                  ? _result!.map((result) {
                      return Card(
                        elevation: 5,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                              "${result['label'].toString().substring(2)} - ${result['confidence'].toStringAsFixed(2)} %",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                      );
                    }).toList()
                  : []),
          InkWell(
            onTap: (){
              pickImageCamera();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Get.height*0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green
                ),
                child: const Center(child: Text("Camera",style: TextStyle(color: Colors.white,fontSize: 23),)),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              pickImage();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Get.height*0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green
                ),
                child: const Center(child: Text("Gallery",style: TextStyle(color: Colors.white,fontSize: 23),)),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              delete();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Get.height*0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green
                ),
                child: const Center(child: Text("Delete",style: TextStyle(color: Colors.white,fontSize: 23),)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // All Future method for image picking

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _result = recognitions!;
      _image = image;
      imageSelected = true;
    });
  }

  Future pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    File image = File(pickedFile!.path);
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _result = recognitions!;
      _image = image;
      imageSelected = true;
    });
  }
  void delete(){
    setState(() {

    });
    _result = null;
    _image = null;
    imageSelected = false;
  }
}
