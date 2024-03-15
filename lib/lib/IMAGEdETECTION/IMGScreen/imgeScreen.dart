// import 'dart:io';
//
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
//
// import '../services/api_service.dart';
//
// class ImageScreen extends StatefulWidget {
//   const ImageScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ImageScreen> createState() => _ImageScreenState();
// }
//
// class _ImageScreenState extends State<ImageScreen> {
//   final apiService = ApiService();
//   File? _selectedImage;
//   String diseaseName = '';
//   String diseasePrecautions = '';
//   bool detecting = false;
//   bool precautionLoading = false;
//
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile =
//     await ImagePicker().pickImage(source: source, imageQuality: 50);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   detectDisease() async {
//     setState(() {
//       detecting = true;
//     });
//     try {
//       diseaseName =
//       await apiService.sendImageToGPT4Vision(image: _selectedImage!);
//     } catch (error) {
//       _showErrorSnackBar(error);
//     } finally {
//       setState(() {
//         detecting = false;
//       });
//     }
//   }
//
//   showPrecautions() async {
//     setState(() {
//       precautionLoading = true;
//     });
//     try {
//       if (diseasePrecautions == '') {
//         diseasePrecautions =
//         await apiService.sendMessageGPT(diseaseName: diseaseName);
//       }
//       _showSuccessDialog(diseaseName, diseasePrecautions);
//     } catch (error) {
//       _showErrorSnackBar(error);
//     } finally {
//       setState(() {
//         precautionLoading = false;
//       });
//     }
//   }
//
//   void _showErrorSnackBar(Object error) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(error.toString()),
//       backgroundColor: Colors.red,
//     ));
//   }
//
//   void _showSuccessDialog(String title, String content) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.success,
//       animType: AnimType.rightSlide,
//       title: title,
//       desc: content,
//       btnOkText: 'Got it',
//       btnOkColor: Colors.white,
//       btnOkOnPress: () {},
//     ).show();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           const SizedBox(height: 20),
//           Stack(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.23,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     // Top right corner
//                     bottomLeft: Radius.circular(50.0), // Bottom right corner
//                   ),
//                   color: Colors.green,
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     // Top right corner
//                     bottomLeft: Radius.circular(50.0), // Bottom right corner
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       // Shadow color with some transparency
//                       spreadRadius: 1,
//                       // Extend the shadow to all sides equally
//                       blurRadius: 5,
//                       // Soften the shadow
//                       offset: const Offset(2, 2), // Position of the shadow
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     ElevatedButton(
//                       onPressed: () {
//                         _pickImage(ImageSource.gallery);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'OPEN GALLERY',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           const SizedBox(width: 10),
//                           Icon(
//                             Icons.image,
//                             color: Colors.white,
//                           )
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _pickImage(ImageSource.camera);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('START CAMERA',
//                               style: TextStyle(color: Colors.white)),
//                            SizedBox(width: 10,),
//                           Icon(Icons.camera_alt, color: Colors.white)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           _selectedImage == null
//               ?Container(
//             margin: const EdgeInsets.all(10),
//             child: Opacity(
//               opacity: 0.9,
//               child: Container(
//                 height: Get.height * 0.3,
//                 color: Colors.green.shade200,
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Lottie.asset('lottie/upload.json',height: Get.height*0.26),
//                       const Text("Upload The Image")
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//               : Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration:
//               BoxDecoration(borderRadius: BorderRadius.circular(20)),
//               padding: const EdgeInsets.all(20),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.file(
//                   _selectedImage!,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           if (_selectedImage != null)
//             detecting
//                 ? SpinKitWave(
//               color: Colors.green,
//               size: 30,
//             )
//                 : Container(
//               width: double.infinity,
//               padding:
//               const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 30, vertical: 15),
//                   // Set some horizontal and vertical padding
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                     BorderRadius.circular(15), // Rounded corners
//                   ),
//                 ),
//                 onPressed: () {
//                   detectDisease();
//                 },
//                 child: const Text(
//                   'DETECT',
//                   style: TextStyle(
//                     color: Colors.white, // Set the text color to white
//                     fontSize: 16, // Set the font size
//                     fontWeight:
//                     FontWeight.bold, // Set the font weight to bold
//                   ),
//                 ),
//               ),
//             ),
//           if (diseaseName != '')
//             Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       DefaultTextStyle(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 16),
//                         child: AnimatedTextKit(
//                             isRepeatingAnimation: false,
//                             repeatForever: false,
//                             displayFullTextOnTap: true,
//                             totalRepeatCount: 1,
//                             animatedTexts: [
//                               TyperAnimatedText(
//                                 diseaseName.trim(),
//                               ),
//                             ]),
//                       )
//                     ],
//                   ),
//                 ),
//                 precautionLoading
//                     ? const SpinKitWave(
//                   color: Colors.blue,
//                   size: 30,
//                 )
//                     : ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 15),
//                   ),
//                   onPressed: () {
//                     showPrecautions();
//                   },
//                   child: const Text(
//                     'PRECAUTION',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
