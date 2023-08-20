import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cloney/models/user.dart' as model;
import 'package:instagram_cloney/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
String username = "";
@override
  void initState() {
    super.initState();
    getUsername();
  }

void getUsername()async {//fetch data from Firebase
  DocumentSnapshot snap =await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get(); // get data from our collection in firebase and get only once its a snapshot
  print(snap.data()); 
  setState(() {
    username = (snap.data() as Map<String,dynamic>)['username'] ;
  });
}

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return  Scaffold(
      body: Center(child: Text(user.email),),
  );}
}