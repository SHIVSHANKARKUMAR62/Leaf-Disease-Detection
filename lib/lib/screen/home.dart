import 'package:detection/screen/account.dart';
import 'package:detection/screen/community.dart';
import 'package:detection/screen/crop.dart';
import 'package:detection/screen/data.dart';
import 'package:detection/screen/homeScreen.dart';
import 'package:detection/screen/post.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;

  List<Widget> screenPart = [
    const Crop(),
    const CommunityScreen(),
    const PostScreen(),
    const AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.energy_savings_leaf),
            label: "Your Crop"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Community"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: "Post"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "You"
          ),
        ],
      ),
      body: screenPart.elementAt(selectedIndex),
    );
  }
}
