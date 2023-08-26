import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_cloney/models/user.dart';
import 'package:instagram_cloney/providers/user_provider.dart';
import 'package:instagram_cloney/utils/colors.dart';
import 'package:instagram_cloney/utils/utils.dart';
import 'package:provider/provider.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}
class _AddPostScreenState extends State<AddPostScreen> {

  final TextEditingController _descriptionController = TextEditingController();
    Uint8List? _file;
   

   @override
  void dispose() {    
    super.dispose();
    _descriptionController.dispose();
  }
  
  _selectImage(BuildContext context)async{
    return showDialog(context: context, builder: (context){
     return SimpleDialog(
      title: const Text('Create a Post'),
      children: [
        SimpleDialogOption(
          padding: EdgeInsets.all(20),
          child: Text('Take a Photo'),
          onPressed: () async {
            Navigator.of(context).pop();
            Uint8List file = await pickImage(ImageSource.camera);
            setState(() {
              _file=file;
            });
          },
        ),

/// this is for IOS users that does not pick images from camera so use gallery.
        SimpleDialogOption(
          padding: EdgeInsets.all(20),
          child: Text('Choose from Gallery'),
          onPressed: () async {
            Navigator.of(context).pop();
            Uint8List file = await pickImage(ImageSource.gallery);
            setState(() {
              _file=file;
            });
          },
        ),

      // in case you just want to cancel the upload process click cancel
        SimpleDialogOption(
          padding: EdgeInsets.all(20),
          child:Center(child:Text('Cancel')),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
     );
    });
  }
  // @override
  // void dispose() {    
  //   super.dispose();
  //   _descriptionController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    //use the provider  to get the user from firebase
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file==null 
    ? Center(
      child: IconButton(
        icon: Icon(Icons.upload),
        onPressed: () {
          //this will be shown wen the file is null 
          _selectImage(context);
        },
      ),
    )
   : Scaffold(
     appBar: AppBar(
      backgroundColor: mobileBackground,
      leading: IconButton(
        onPressed:() {},
        icon: Icon(Icons.arrow_back),),
        title: const Text('Post Page'),
        centerTitle: false,
        actions: [
          TextButton(onPressed: (){},
           child: const Text('post',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                   color: Colors.blueAccent,
                   fontSize: 16,),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/me.jpg'),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.5,
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'write a caption here!! ',
                ),
                maxLines: 1,
              ),
              ),
              SizedBox(height: 45,width: 45,
              child: AspectRatio(aspectRatio: 487/451,
              child: Container(
                decoration: BoxDecoration( 
                  image: DecorationImage(
                    //shld hv used MemoryImage(_file!) but the file picker is not working properly
                    image: AssetImage('assets/tree.jpg'),
                    fit: BoxFit.fill,
                    alignment: FractionalOffset.topCenter),

                ),
              ),
                ),
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}