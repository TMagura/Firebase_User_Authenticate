// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_cloney/resources/auth_methods.dart';
import 'package:instagram_cloney/responsive/mobile_screen_layout.dart';
import 'package:instagram_cloney/responsive/responsive_layout_screen.dart';
import 'package:instagram_cloney/responsive/web_screen_layout.dart';
import 'package:instagram_cloney/screens/signup_screen.dart';
import 'package:instagram_cloney/utils/colors.dart';
import 'package:instagram_cloney/utils/utils.dart';
import 'package:instagram_cloney/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //create the listenners for the inputfield
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    bool _isLoading = false;
    @override
    //very important we have to dispose our controllers
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser()async{//login user if the authentication was done properly
    setState(() {
      _isLoading= true;
    });
   String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
   if (res == "sucess") {
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()),
          ),
      );
   }else{
    setState(() {
      _isLoading= false;
    });
    showSnackBar(context,res);
   }
  }
    void navigateToSignup(){
      Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(),flex: 2,),

              //logo re instagram SVG Image but used nomal image
                Image.asset('assets/ig_image.png',
                height: 64,),
                const SizedBox(height: 70,),

              //text field of email/username
              TextFieldinput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              SizedBox(height: 25,),

              //text field of password obscured
              TextFieldinput(
                hintText: 'Enter your Pasword',
                textInputType: TextInputType.emailAddress,
                textEditingController: _passwordController,
                isPass: true,
              ),
              SizedBox(height: 25,),
              //buttom for login using a container instead
              InkWell(
                onTap: loginUser,
                child: Container( 
                  child: _isLoading 
                  ? const CircularProgressIndicator(
                    color: primaryColor,) 
                  : const Text('Log In'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: blueColor,
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              Flexible(child: Container(),flex: 2,),
              //link to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an Account", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:navigateToSignup,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text('Sign Up', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                        ),
                      ),                   
                    ),
                  ),
                  
                ],
              ),
            ],
          ) ,
        ),
      ),
    );
  }
}