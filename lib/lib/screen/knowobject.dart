import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class Know extends StatefulWidget {
  const Know({Key? key}) : super(key: key);

  @override
  State<Know> createState() => _KnowState();
}

class _KnowState extends State<Know> {
  XFile? imageFile;
  bool imageLabelChecking = false;
  String imageLabel = "";

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    imageFile = null;
    imageLabelChecking = false;
    imageLabel = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Picture Things"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (imageLabelChecking) const CircularProgressIndicator(),
              if (!imageLabelChecking && imageFile == null)
                Container(
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
              if (imageFile != null)
                SizedBox(
                    height: Get.height * 0.3,
                    width: double.infinity,
                    child: Image.file(File(imageFile!.path),fit: BoxFit.cover,)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Know the Picture capture things",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,decorationStyle: TextDecorationStyle.dashed)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: imageLabel.isEmpty?const Center(
                            child: Text("No Image Selected",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 25)),
                          ):Text(imageLabel, style: const TextStyle(fontSize: 20)),
                        )),
              ),
              InkWell(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Get.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: const Center(
                        child: Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    )),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Get.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: const Center(
                        child: Text(
                          "Camera",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        )),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  delete();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Get.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green),
                    child: const Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      imageLabelChecking = true;
      imageFile = pickedImage;
      setState(() {
        getImageLabels(pickedImage!);
      });
    } catch (e) {
      imageLabelChecking = false;
      imageFile = null;
      imageLabel = "No Image Selected";
      setState(() {});
    }
  }

  void getImageLabels(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    ImageLabeler imageLabeler = ImageLabeler(options: ImageLabelerOptions());
    List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    StringBuffer sb = StringBuffer();
    for (ImageLabel imageLabel in labels) {
      String lblText = imageLabel.label;
      double confidence = imageLabel.confidence;
      sb.write(lblText);
      sb.write(" : ");
      sb.write((confidence * 100).toStringAsFixed(2));
      sb.write("%\n");
    }
    imageLabeler.close();
    imageLabel = sb.toString();
    imageLabelChecking = false;
    setState(() {});
  }

  void delete(){
    imageLabelChecking = false;
    imageFile = null;
    imageLabel = "No Image Selected";
    setState(() {});
  }
}
