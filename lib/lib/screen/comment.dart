import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class CommentScreen extends StatefulWidget {

  final data;
  final id;
  const CommentScreen({Key? key ,required this.data,required this.id}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
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
        title: const Text("Comment"),
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("post").doc(widget.id).collection("comments").where("dataUid",isEqualTo: widget.data["docId"]).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Lottie.asset('lottie/nodata.json'),
                        const Text("No comment...")
                      ],
                    ),
                  ));
                } else {
                  final data = snapshot.data!.docs;
                  final list = [];
                  list.shuffle();
                  for (var i in data) {
                    list.add(i.data());
                  }
                  return ListView.builder(
                     reverse: true,
                    shrinkWrap: true,
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      var docId = snapshot.data!.docs[index].id;
                      return GestureDetector(
                        onLongPress: (){
                         // Get.snackbar("Delete", "Do u want to delete this comment?");
                          Get.defaultDialog(
                            barrierDismissible: false,
                            title: "Delete",
                            middleText: "Do u want to delete this comment?",
                            onCancel: () => Get.closeCurrentSnackbar(),
                            onConfirm: ()async => await FirebaseFirestore.instance.collection("post").doc(widget.id).collection("comments").doc(docId).delete().whenComplete(() => Get.back())
                          );
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(list[index]["commentName"]),
                                    // IconButton(onPressed: () async{
                                    //   await FirebaseFirestore.instance.collection("post").doc(widget.id).collection("comments").doc(docId).delete();
                                    // }, icon: const Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(list[index]["comment"]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 2,
                    controller: controller,
                    decoration: InputDecoration(hintText: "Comment Please...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )),
                  ),
                ),
                IconButton(onPressed: () async{
                  try{
                    EasyLoading.show(status: "Sent...");
                    await FirebaseFirestore.instance.collection("post").doc(widget.id).collection("comments").doc().set({
                      "comment":controller.text.toString(),
                      "dataUid" : widget.data["docId"],
                      "uid":FirebaseAuth.instance.currentUser!.uid,
                      "date":DateTime.now().millisecondsSinceEpoch,
                      "postName" : widget.data["name"],
                      "commentName" : FirebaseAuth.instance.currentUser!.displayName,
                    }).whenComplete(() {
                      EasyLoading.dismiss();
                      controller.clear();
                    });
                  }catch(e){
                    EasyLoading.dismiss();
                  }

                }, icon: const Icon(Icons.send,size: 40,))
              ],
            ),
          ),

        ],
      ),
    );
  }
}
