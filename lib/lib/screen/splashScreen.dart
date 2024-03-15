import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    final user = _auth.currentUser;
    super.initState();
    if(user!=null){
      Timer(const Duration(seconds: 3),() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
      },);
    }else{
      Timer(const Duration(seconds: 3),() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Lottie.asset('lottie/splash.json'),
      ),
    );
  }
}
