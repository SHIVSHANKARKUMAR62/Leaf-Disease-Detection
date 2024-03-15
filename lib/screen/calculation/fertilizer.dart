import 'package:detection/models/calculation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fertilizer extends StatefulWidget {
  const Fertilizer({Key? key}) : super(key: key);

  @override
  State<Fertilizer> createState() => _FertilizerState();
}

class _FertilizerState extends State<Fertilizer> {
  
  
  Calculation controller = Get.put(Calculation());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fertilizer Calculation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,bottom: 18),
                    child: Text("Nutrient quantities",style: TextStyle(fontSize: Get.width*0.07)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: Get.height*0.1,
                        width: Get.width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade300
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: controller.nController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(border: InputBorder.none,hintText: "N %"),
                          ),
                        ),
                      ),
                      Container(
                        height: Get.height*0.1,
                        width: Get.width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade300
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: controller.pController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(border: InputBorder.none,hintText: "P %"),
                          ),
                        ),
                      ),
                      Container(
                        height: Get.height*0.1,
                        width: Get.width*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade300
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: controller.kController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(border: InputBorder.none,hintText: "K %"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0,bottom: 18,top: 20),
                    child: Text("Units",style: TextStyle(fontSize: Get.width*0.07)),
                  ),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: Get.height*0.1,
                          width: Get.width*0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: controller.aClick.value==true?Colors.green.shade500:Colors.grey.shade300
                          ),
                          child: const Center(child: Text("Acre")),
                        ),
                        onTap: (){
                          controller.aClick.value = true;
                          controller.hClick.value = false;
                          controller.gClick.value = false;
                          if(controller.a.value==1){
                            controller.unit1Caluclation();
                            controller.unit.value = "acre";
                            controller.a.value = 0;
                            controller.b.value = 1;
                            controller.c.value = 1;
                          }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: Get.height*0.1,
                          width: Get.width*0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: controller.hClick.value==true?Colors.green.shade500:Colors.grey.shade300
                          ),
                          child: const Center(child: Text("Hectare")),
                        ),
                        onTap: (){
                          controller.aClick.value = false;
                          controller.hClick.value = true;
                          controller.gClick.value = false;
                          if(controller.b.value==1){
                            controller.unit2Caluclation();
                            controller.unit.value = "hectare";
                            controller.b.value = 0;
                            controller.a.value = 1;
                            controller.c.value = 1;
                          }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: Get.height*0.1,
                          width: Get.width*0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: controller.gClick.value==true?Colors.green.shade500:Colors.grey.shade300
                          ),
                          child: const Center(child: Text("Gunta")),
                        ),
                        onTap: (){
                          controller.aClick.value = false;
                          controller.hClick.value = false;
                          controller.gClick.value = true;
                          if(controller.c.value==1){
                            controller.caluclation();
                            controller.unit.value = "gunta";
                            controller.c.value = 0;
                            controller.b.value = 1;
                            controller.a.value = 1;
                          }
                        },
                      ),
                    ],
                  ),)
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Plot Size",style: TextStyle(fontSize: Get.width*0.07),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      height: Get.height*0.1,
                      width: Get.width*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300
                      ),
                      child: Center(child: Text("-",style: TextStyle(fontSize: Get.width*0.07),)),
                    ),
                    onTap: (){
                      controller.decrement();
                    },
                  ),

                  Container(
                    height: Get.height*0.1,
                    width: Get.width*0.3,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.greenAccent.shade400
                    ),
                    child: Center(child: Obx(() => Text("  ${controller.area.value.toString()} \n ${controller.unit.value.toString()}",style: TextStyle(fontSize: Get.width*0.07),))),
                  ),
                  GestureDetector(
                    child: Container(
                      height: Get.height*0.1,
                      width: Get.width*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(child: Text("+",style: TextStyle(fontSize: Get.width*0.07),)),
                    ),
                    onTap: (){
                      controller.increment();
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                if(controller.b.value == 0 && controller.a.value == 1 && controller.c.value == 1 ){
                  controller.unit2Caluclation();
                }else if(controller.b.value == 1 && controller.a.value == 0 && controller.c.value == 1 ){
                  controller.unit1Caluclation();
                }else if(controller.b.value == 1 && controller.a.value == 1 && controller.c.value == 0 ){
                  controller.caluclation();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: Get.height*0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green
                  ),
                  child: Center(child: Text("Calculate",style: TextStyle(color: Colors.white,fontSize: Get.width*0.07),)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: Card(color: Colors.grey.shade300,child: Obx(() =>  SizedBox(
                        width: double.infinity,
                        child: Center(child: Text(" ${controller.resultU.toStringAsFixed(2)} kg urea",style: TextStyle(fontSize: Get.width*0.07)))),))),
                    Center(child: Card(color: Colors.grey.shade300,child: Obx(() =>  SizedBox(
                        width: double.infinity,
                        child: Center(child: Text(" ${controller.resultSSP.toStringAsFixed(2)} kg SSP",style: TextStyle(fontSize: Get.width*0.07)))),))),
                    Center(child: Card(color: Colors.grey.shade300,child: Obx(() =>  SizedBox(
                        width: double.infinity,
                        child: Center(child: Text(" ${controller.resultMOP.toStringAsFixed(2)} kg MOP",style: TextStyle(fontSize: Get.width*0.07)))),))),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
