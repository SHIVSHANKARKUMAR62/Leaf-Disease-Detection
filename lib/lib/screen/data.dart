import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/loginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {

  var controller = Get.put(Google());

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('post').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Post..."));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return Card(
                  child: Stack(
                    children: [
                      Positioned(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data["name"]),
                            ),
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(data['img'],fit: BoxFit.cover),
                                  )),
                            ),
                            SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data['question']),
                                  )),
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: () async{
                                  if(data["like"]==true) {
                                    await FirebaseFirestore.instance.collection(
                                        "post").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                      "like": false,
                                    });
                                  }else{
                                    await FirebaseFirestore.instance.collection(
                                        "post").doc(FirebaseAuth.instance.currentUser!.uid).update({

                                      "like": true,
                                    });
                                  }
                                }, icon: data['like']==false?const Icon(Icons.energy_savings_leaf_outlined):const Icon(Icons.energy_savings_leaf_outlined,color: Colors.green,)),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.comment)),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.screen_share_rounded)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],

                  ),
                );
              }).toList(),
            );
          },
        ) ,
      ),
    );
  }
}
