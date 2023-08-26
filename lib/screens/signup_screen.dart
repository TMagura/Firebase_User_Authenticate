import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instagram_cloney/resources/auth_methods.dart';
import 'package:instagram_cloney/responsive/mobile_screen_layout.dart';
import 'package:instagram_cloney/responsive/responsive_layout_screen.dart';
import 'package:instagram_cloney/responsive/web_screen_layout.dart';
import 'package:instagram_cloney/screens/login_screen.dart';
import 'package:instagram_cloney/utils/colors.dart';
import 'package:instagram_cloney/utils/utils.dart';
import 'package:instagram_cloney/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //create the listenners for the inputfield
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
    @override
    //very important we have to dispose our controllers
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage()async{// select the image using the image picker
    Uint8List im =await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }


  void signUpUsers() async{ //sign user method
  setState(() {
    _isLoading = true;
  });
     String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
    username: _usernameController.text,
      bio: _bioController.text,
    // file:_image!,
      );
      setState(() {
      _isLoading = false;
     });
    if(res != 'success'){
     showSnackBar(context, res);
    } else{
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout()),
        ),
      );
    }
  }

      void navigateToLogin(){//Navigate to 
      Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120,),
                //logo re instagram SVG Image but used normal image
                  Image.asset('assets/ig_image.png',
                  height: 64,),
                  const SizedBox(height: 12,),
          
                   // a circle Avator for the prof pic
                   Stack(
                    children: [
                      _image!=null
                      ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                      : const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('assets/default.jpg'),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 90,
                        child: IconButton(
                        onPressed:
                        selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),),
                      ],
                     ),
                   const SizedBox(height: 12,),
                   // username input field
                TextFieldinput(
                  hintText: 'Enter your Username',
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                  
                ),
                SizedBox(height: 12,),
                //text field of email/username
                TextFieldinput(
                  hintText: 'Enter your Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                SizedBox(height: 12,),
          
                //text field of password obscured
                TextFieldinput(
                  hintText: 'Enter your Pasword',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                SizedBox(height: 12,),
          
                // bio text field
                TextFieldinput(
                  hintText: 'Enter your Bio',
                  textInputType: TextInputType.text,
                  textEditingController: _bioController,  
                ),
                SizedBox(height: 12,),
                //buttom for login using a container instead
                InkWell(
                  onTap:signUpUsers,
                  child: Container( 
                    child: _isLoading
                     ?  Center(child: CircularProgressIndicator(
                      color: primaryColor,
                     ),) 
                     :Text('Sign Up'),
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
                const SizedBox(height: 20,),
                
                //link to sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 8),
                    //   child: const Text("Don't have an Account ?___", 
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap:navigateToLogin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Do you have an Account? Login here", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                          ),
                        ),                   
                      ),
                    ),
                    
                  ],
                ), 
              ],
            ),
          ) ,
        ),
      ),
    );
  }


}