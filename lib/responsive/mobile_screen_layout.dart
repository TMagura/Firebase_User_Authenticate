import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cloney/models/user.dart' as model;
import 'package:instagram_cloney/providers/user_provider.dart';
import 'package:instagram_cloney/utils/colors.dart';
import 'package:instagram_cloney/utils/global_variables.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
// String username = "";
// @override
//   void initState() {
//     super.initState();
//     getUsername();
//   }

// void getUsername()async {//fetch data from Firebase
//   DocumentSnapshot snap =await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get(); // get data from our collection in firebase and get only once its a snapshot
//   print(snap.data());
//   setState(() {
//     username = (snap.data() as Map<String,dynamic>)['username'] ;
//   });
// }

  int _page = 0; // use for the page count
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children:homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackground,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
