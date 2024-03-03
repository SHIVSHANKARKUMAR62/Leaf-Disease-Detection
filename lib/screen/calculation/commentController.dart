import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CommentData extends StatefulWidget {

  final data;
  const CommentData({Key? key,required this.data}) : super(key: key);

  @override
  State<CommentData> createState() => _CommentDataState();
}

class _CommentDataState extends State<CommentData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("comments").where("dataUid",isEqualTo: widget.data["docId"]).snapshots(),
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
              for (var i in data) {
                list.add(i.data());
              }
              return ListView.builder(
               shrinkWrap: true,
                primary: false,
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
                          child: Text(list[index]["commentName"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(list[index]["comment"]),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),

      ],
    );
  }
}
