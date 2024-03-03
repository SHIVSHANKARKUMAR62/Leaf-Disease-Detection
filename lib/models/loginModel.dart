import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screen/home.dart';

class Google extends GetxController{


  // google sign
  void signInWithGoogle() async {
    EasyLoading.show(status: 'loading...');
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential).whenComplete(() {
          FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid).set({
            "name": googleUser!.displayName.toString(),
            "email": googleUser.email.toString(),
            "id": googleUser.id.toString(),
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "docId": FirebaseFirestore.instance.collection("user").doc(),
            "img" : FirebaseAuth.instance.currentUser!.photoURL
          });
          EasyLoading.dismiss();
        Get.offAll(() => const Home());
      });
    }on FirebaseAuthException catch(e){
      EasyLoading.dismiss();
      Get.snackbar("Error",e.code.toString() );
    }
  }

  signOut(){
    EasyLoading.show(status: "Loading...");
    FirebaseAuth.instance.signOut();
    Get.offAll( ()=> const LoginScreen());
    EasyLoading.dismiss();
  }

}