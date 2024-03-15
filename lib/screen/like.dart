import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LikeScreen extends StatefulWidget {

  final data;
  const LikeScreen({Key? key ,required this.data}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Likes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height*0.33,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("likes").where("dataUid",isEqualTo: widget.data["docId"]).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.data!.docs.isEmpty) {
                              return const Center(child: Text("No Likes..."));
                            } else {
                              final data = snapshot.data!.docs;
                              final list = [];
                              for (var i in data) {
                                list.add(i.data());
                              }
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index) {
                                  var docId = snapshot.data!.docs[index].id;
                                  return Card(
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    elevation: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(list[index]["likeName"]),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
