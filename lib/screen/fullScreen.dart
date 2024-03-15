import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FullScreen extends StatefulWidget {
  final data;
  const FullScreen({Key? key,required this.data}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Plant"),
      ),
      body: SizedBox(
        height: double.infinity,
         width: double.infinity,
         child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             children: [
               ...List.generate(widget.data['img'].length, (i) => Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SizedBox(
                     width: Get.width*0.88,
                     child: Image.network(widget.data['img'][i],fit: BoxFit.scaleDown)),
               ))
             ],
           ),
         )

         //Image.network(widget.data['img'],fit: BoxFit.contain,),
      )
    );
  }
}
