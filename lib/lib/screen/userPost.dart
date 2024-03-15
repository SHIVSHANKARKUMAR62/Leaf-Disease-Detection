import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import 'comment.dart';
import 'fullScreen.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key,}) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Post"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("post").where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Lottie.asset('lottie/nodata.json'),
                        const Text("No Post...")
                      ],
                    ),
                  ));
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data[index]["name"]),
                                ),
                                IconButton(onPressed: ()async{
                                  await FirebaseFirestore.instance.collection("post").doc(docId).delete();
                                }, icon: const Icon(Icons.delete)),
                              ],
                            ),
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...List.generate(data[index]['img'].length, (i) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                                width: Get.width*0.88,
                                                child: InteractiveViewer(
                                                    maxScale: 5,
                                                    child: Image.network(list[index]['img'][i],fit: BoxFit.scaleDown,))),
                                          ))
                                        ],
                                      ),
                                    ),
                                  )),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(list[index]["question"]),
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: () async{
                                  if(list[index]["likeC"].contains(FirebaseAuth.instance.currentUser!.uid)){
                                    await FirebaseFirestore.instance.collection("post").doc(docId).update({
                                      'likeC' : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
                                    });
                                  }else{
                                    await FirebaseFirestore.instance.collection("post").doc(docId).update({
                                      'likeC' : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
                                    });
                                  }
                                }, icon:(!list[index]["likeC"].contains(FirebaseAuth.instance.currentUser!.uid))? const Icon(Icons.energy_savings_leaf_outlined)
                                    :const Icon(Icons.energy_savings_leaf_outlined,color: Colors.green,)),
                                //:const Icon(Icons.energy_savings_leaf_outlined,color: Colors.green,))
                                IconButton(onPressed: (){
                                  Get.to(()=>CommentScreen(data: data[index],id: docId,));
                                }, icon: const Icon(Icons.comment)),
                                IconButton(onPressed: (){
                                  Share.share("Image is: ${list[index]['img'][0]} and question is: ${list[index]['question']}");
                                }, icon: const Icon(Icons.screen_share_rounded)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: Get.width*0.05,bottom: Get.height*0.02),
                              child: Text("${list[index]["likeC"].length.toString()} likes"),
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
        ],
      ),
    );
  }
}
