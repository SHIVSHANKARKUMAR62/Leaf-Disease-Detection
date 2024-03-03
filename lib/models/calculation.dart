import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Calculation extends GetxController{
  TextEditingController nController = TextEditingController();
  TextEditingController pController = TextEditingController();
  TextEditingController kController = TextEditingController();
  RxDouble area = 0.5.obs,n = 0.0.obs,p = 0.0.obs,k = 0.0.obs,resultU = 0.0.obs,resultSSP = 0.0.obs,resultMOP = 0.0.obs;
  RxInt a = 1.obs,b = 1.obs,c = 1.obs;
  RxString unit = "".obs;
  RxBool aClick = false.obs;
  RxBool hClick = false.obs;
  RxBool gClick = false.obs;

  increment(){
      area.value += 0.5;
  }
  decrement(){
    if(area>0.5){
      area.value -= 0.5;
    }
  }


  // result in KG of urea/ssp/mop is needed to supply 100:50:50 kg of of NPK to 1 hectare paddy  Ans is 217.4 urea, 312.5 ssp, 83.3 mop

  unit1Caluclation(){
    if(nController.text.isEmpty){
      nController.text = "0";
    }
    resultU.value = double.parse(nController.text.toString())/46*100*area.value;
    if(pController.text.isEmpty){
      pController.text = "0";
    }
    resultSSP.value = double.parse(pController.text.toString())/16*100*area.value;
    if(kController.text.isEmpty){
      kController.text = "0";
    }
    resultMOP.value = double.parse(kController.text.toString())/60*100*area.value;
      resultU.value *= 2.471;
      resultMOP.value *= 2.471;
      resultSSP.value *= 2.471;
      update();
  }
  unit2Caluclation(){
    if(nController.text.isEmpty){
      nController.text = "0";
    }
    resultU.value = double.parse(nController.text.toString())/46*100*area.value;
    if(pController.text.isEmpty){
      pController.text = "0";
    }
    resultSSP.value = double.parse(pController.text.toString())/16*100*area.value;
    if(kController.text.isEmpty){
      kController.text = "0";
    }
    resultMOP.value = double.parse(kController.text.toString())/60*100*area.value;
    update();

  }
  caluclation(){
    if(nController.text.isEmpty){
      nController.text = "0";
    }
    resultU.value = double.parse(nController.text.toString())/46*100*area.value;
    if(pController.text.isEmpty){
      pController.text = "0";
    }
    resultSSP.value = double.parse(pController.text.toString())/16*100*area.value;
    if(kController.text.isEmpty){
      kController.text = "0";
    }
    resultMOP.value = double.parse(kController.text.toString())/60*100*area.value;
    resultU.value *= 98.84;
    resultMOP.value *= 98.84;
    resultSSP.value *= 98.84;
    update();
  }

}