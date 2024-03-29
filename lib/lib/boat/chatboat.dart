// import 'package:dialog_flowtter/dialog_flowtter.dart';
// import 'package:flutter/material.dart';
//
// import 'MessagesScreen.dart';
//
// class ChatBoatMessages extends StatefulWidget {
//   const ChatBoatMessages({Key? key}) : super(key: key);
//
//   @override
//   State<ChatBoatMessages> createState() => _ChatBoatMessagesState();
// }
//
// class _ChatBoatMessagesState extends State<ChatBoatMessages> {
//   late DialogFlowtter dialogFlowtter;
//   final TextEditingController _controller = TextEditingController();
//
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
//   }
//#  flutter_spinkit: ^5.2.0
// #  dio: ^5.3.3
// #  animated_text_kit: ^4.2.2
// #  awesome_dialog: ^3.1.0
// ##  dialog_flowtter:
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DialogFlowtter app'),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: MessagesScreen(messages: messages)),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//               vertical: 5,
//             ),
//             color: Colors.blue,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 IconButton(
//                   color: Colors.white,
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     sendMessage(_controller.text);
//                     _controller.clear();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void sendMessage(String text) async {
//     if (text.isEmpty) return;
//     setState(() {
//       addMessage(
//         Message(text: DialogText(text: [text])),
//         true,
//       );
//     });
//
//     // dialogFlowtter.projectId = "deimos-apps-0905";
//
//     DetectIntentResponse response = await dialogFlowtter.detectIntent(
//       queryInput: QueryInput(text: TextInput(text: text)),
//     );
//
//     if (response.message == null) return;
//     setState(() {
//       addMessage(response.message!);
//     });
//   }
//
//   void addMessage(Message message, [bool isUserMessage = false]) {
//     messages.add({
//       'message': message,
//       'isUserMessage': isUserMessage,
//     });
//   }
//
//   @override
//   void dispose() {
//     dialogFlowtter.dispose();
//     super.dispose();
//   }
// }
