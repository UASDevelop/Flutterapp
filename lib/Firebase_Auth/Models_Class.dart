import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Firebase_Auth/LogIn_Page.dart';

import '../Screen/Navigation_Bar.dart';
import 'Sign_UP.dart';

class Firebases {
  Future signOutse() async {
    var User = await FirebaseAuth.instance.signOut();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      LogInPage();
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void Loginauth(String email, String password, BuildContext context) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNaivgation()));
    }
  }

  void SignUp(String email, String password, BuildContext context) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogInPage()));
    }
  }

  void AddData(String email, String password, String deviceid,) async {
    var UId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore _storeage = FirebaseFirestore.instance;
     await _storeage.collection('User').add({
      'email': email,
      'uid': UId,
      'deviceId': deviceid,
    });
  }

}
