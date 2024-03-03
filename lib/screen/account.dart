import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/loginModel.dart';
import 'package:detection/screen/userPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {


  var controller = Get.put(Google());

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').where("uid", isEqualTo:  FirebaseAuth.instance.currentUser!.uid,).snapshots();
  final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance.collection('post').where("uid", isEqualTo:  FirebaseAuth.instance.currentUser!.uid,).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Lottie.asset('lottie/user.json',height: Get.height*0.3),
                    const Text("User Detail",style: TextStyle(fontSize: 20)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _usersStream,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading...");
                            }

                            return ListView(
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(data['name']),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      width: double.infinity,
                                      child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(data['email']),
                                          )),
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ) ,
                      ),
                    ),
                    const Text("Post Detail",style: TextStyle(fontSize: 20)),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _postStream,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading...");
                            }

                            return Column(
                              children: [
                                Card(
                                    child: ListTile(
                                      title: const Text("Total Post",style: TextStyle(fontSize: 20)),
                                      trailing: Text(snapshot.data!.size.toString(),style: const TextStyle(fontSize: 20)),
                                    onTap: (){
                                        Get.to(()=>const UserPost());
                                    },
                                    ),
                                ),
                                Card(
                                    child: ListTile(
                                      title: const Text("Log Out",style: TextStyle(fontSize: 20)),
                                      trailing:  const Icon(Icons.logout),
                                      onTap: (){
                                        Google().signOut();
                                      },
                                    ),),
                              ],
                            );
                          },
                        ) ,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
