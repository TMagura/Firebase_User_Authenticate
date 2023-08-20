import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_cloney/providers/user_provider.dart';
import 'package:instagram_cloney/responsive/mobile_screen_layout.dart';
import 'package:instagram_cloney/responsive/responsive_layout_screen.dart';
import 'package:instagram_cloney/responsive/web_screen_layout.dart';
import 'package:instagram_cloney/screens/login_screen.dart';
import 'package:instagram_cloney/screens/signup_screen.dart';
import 'package:instagram_cloney/utils/colors.dart';
// import 'package:instagram_cloney/utils/dimensions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  if(kIsWeb){
      await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyAFjp1bgzLh9SWj-zcHJ-whRIJjFbV2ULA',
          appId: '1:789400167592:web:aae803bff32bc5eeac4e9d',
          messagingSenderId: '789400167592',
          projectId: 'instagram-cloney',
          storageBucket: 'instagram-cloney.appspot.com',
         ),
      );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme:ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackground,
        ),
        // home: const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout:WebScreenLayout()),
      home:
       StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),// use predefined firebase methods to check user Logins/out
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.active){// check connection btwn client an firebase    
            if(snapshot.hasData){
               return const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout:WebScreenLayout());
            }else if(snapshot.hasError){
               Center(child: Text("${snapshot.error}"),);
            }
          }if(snapshot.connectionState==ConnectionState.waiting){
               return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
               );
          }
          return const LoginScreen();//if connection is unavailable then return to login screen
        }),
      ),
    );
  }
}