import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User{
  final String email;
  final String uid;
  // final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({ //constructor of our items
    required this.email,
    required this.uid,
    // required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following
  });

Map<String,dynamic> toJson()=>{ // our data to jason format so that its workable in the Firebase
    "email":email,
    "uid":uid,
    // "photoUrl":photoUrl,
    "username":username,
    "bio":bio,
    "followers":followers,
    "following":following,
};

    //take doc snap shot and return user model
    static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return User(
      username: snapshot['username'],
      uid:snapshot['uid'],
      email:snapshot['email'],
      bio:snapshot['bio'],
      followers:snapshot['followers'],
      following:snapshot['following'],
    );
    }
}