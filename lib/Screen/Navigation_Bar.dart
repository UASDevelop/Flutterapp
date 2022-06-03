import 'package:flutter/material.dart';
import 'package:flutterapp/Screen/DiscoveryPage.dart';
import 'package:flutterapp/Screen/Profiles_dart.dart';

import 'Home_dart.dart';
class BottomNaivgation extends StatefulWidget {
  const BottomNaivgation({Key? key}) : super(key: key);

  @override
  _BottomNaivgationState createState() => _BottomNaivgationState();
}

class _BottomNaivgationState extends State<BottomNaivgation> {
  void onTabTapped(int index) {
    setState(() {
      currentindex = index;
    });
  }

  final List changevalues=[
    DiscoveryPage(),
    Profiles()
  ];
  int currentindex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:changevalues[currentindex],

      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        currentIndex: currentindex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home_outlined,size: 60,),
              label: 'Home'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 60,),
              label:'Person'
          ),
        ],
        onTap:  onTabTapped,
      ),
    );
  }
}
