import 'package:detection/IMAGEdETECTION/IMGScreen/imgeScreen.dart';
import 'package:detection/boat/chatboat.dart';
import 'package:detection/screen/calculation/fertilizer.dart';
import 'package:detection/screen/homeScreen.dart';
import 'package:detection/screen/knowobject.dart';
import 'package:detection/weather/locationSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../weather/controller/main_controller.dart';

class Crop extends StatefulWidget {
  const Crop({Key? key}) : super(key: key);

  @override
  State<Crop> createState() => _CropState();
}

class _CropState extends State<Crop> {

  var controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Get.to(()=>const ChatBoatMessages());
      //   },
      //   child: const Text("Chart"),
      // ),
      appBar: AppBar(
        title: const Text("Crop Plant"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: Get.height*0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50)),
                  color: Colors.blueGrey.shade200,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(()=>const Fertilizer());
                      },
                      child: Container(
                        height: Get.height*0.1,
                        width: Get.width*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.energy_savings_leaf_outlined),
                            Text("Fertilizer calculator")
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        launchUrl(Uri.parse("https://en.wikipedia.org/wiki/Pest_(organism)"));
                      },
                      child: Container(
                        height: Get.height*0.1,
                        width: Get.width*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.pest_control_rodent),
                            Text("Pests & diseases")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0,left: 20,bottom: 5),
              child: Text("Heal your crop",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
            ),
            InkWell(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                child: SizedBox(
                  height: Get.height*0.28,
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.document_scanner,size: 50),
                        const Text("Take a Picture"),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: Get.height*0.07,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child: const Center(child: Text("Take a Picture",style: TextStyle(fontSize: 20,color: Colors.white),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0,left: 20,bottom: 5),
              child: Text("Weather",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
            ),
            InkWell(
              onTap: (){
                if(controller.isloaded.isTrue) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const Weather(),));
                }else{
                  controller.getUserLocation();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const Weather(),));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                child: SizedBox(
                  height: Get.height*0.28,
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Lottie.asset('lottie/weather.json',width: Get.height*0.1),
                        const Center(child: Text("Know The Weather Condition")),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: Get.height*0.07,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade500,
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child: const Center(child: Text("Weather",style: TextStyle(fontSize: 20,color: Colors.white),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0,left: 20,bottom: 5),
              child: Text("Know the capture things",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,decorationStyle: TextDecorationStyle.dashed)),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Know(),));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                child: SizedBox(
                  height: Get.height*0.28,
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.picture_in_picture_alt_outlined,size: 50),
                        const Text("Take a Picture"),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: Get.height*0.07,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade500,
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child: const Center(child: Text("Know the Picture things",style: TextStyle(fontSize: 20,color: Colors.white),)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
