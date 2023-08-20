import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class StorageMethods{
  // create an instance first
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;//to get the user id
  Future<String> uploadImageToStorage(String childName, Uint8List file , bool isPost) async {
     Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
     UploadTask uploadTask = ref.putData(file);//to upload we use the putData method
     TaskSnapshot snap = await uploadTask; //take the snap shots of the process
     String downloadUrl = await snap.ref.getDownloadURL();//get the url of our downloaded file
    return downloadUrl;
  }
}
