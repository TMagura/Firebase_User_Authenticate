import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cloney/models/user.dart' as model; // use 'as' to avoid clash with the other packages
import 'package:instagram_cloney/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      
   Future<model.User> getUserDetails()async{ //get user details from the firebase
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap); // called a method that creatd the snapshot for us 
   }

  Future<String> signUpUser({ //user to signup the user
    required String email,
    required String password,
    required String username,
    required String bio,
    // required Uint8List file,
  }) async{
 String res = "fill in all the required items";
 try {
   if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty){/*||file!=null*/
    // registering the user to firebase Auth which only accepts email and password

    UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   print(cred.user!.uid);

       model.User user = model.User(
      username: username,
      uid:cred.user!.uid,
      email:email,
      bio:bio,
      followers:[],
      following:[],
      
    );
    // String photoUrl =await StorageMethods().uploadImageToStorage('profilePics', file, false);
    //to save other things like bio we use Firebase 
   await _firestore.collection('users').doc(cred.user!.uid).set(// set the user in the collection database in firebase
       user.toJson(),
      // 'photoUrl':photoUrl,
    );
    ///we can also use the .add like so
    // await _firestore.collection('users').add({
    //   'username': username,
    //   'uid':cred.user!.uid,
    //   'email':email,
    //   'bio':bio,
    //   'foloowers':[],
    //   'following':[],
    // });
    res = "success";
   }
   }on FirebaseAuthException catch(err){
    if(err.code == 'invalid-email'){
      res = "this email is not correct";
    }
   }
  catch (err) {
   res = err.toString();
 }
 return res;
  }

  ///this is for the login of user
  Future<String> loginUser({
    required String email,
    required String password
  }) async{
    String res = "some error occured in login";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      }else{res="fields cant be empty";}
    } on FirebaseAuthException catch(e){
      if(e.code == 'invalid-email'){
        res="invalid email produced";
      }
    } 
    catch (e) {
      res= e.toString();
    }
    return res;
  }
}