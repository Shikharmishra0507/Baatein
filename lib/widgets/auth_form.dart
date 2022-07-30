import 'dart:io';
import 'package:chat/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  static final _key = GlobalKey<FormState>();

  AuthForm(this.submitFunction);
  final void Function (
      String email,
      String password,
      String username,
      File? image,
      bool isLogin) submitFunction;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String _userName='';

  String _userEmail='';

  String _userPassword='';

  bool isLogin=true;
  bool isLoading=false;
  File ?_pickedImage;
  void _imagePickerFunction(File? pickedImage){
    _pickedImage=pickedImage;

  }
  void _trySubmit(BuildContext context) async{
    FocusScope.of(context).unfocus();
    if(_pickedImage==null && !isLogin){
      showDialog(context: context,
          builder:(context)=>AlertDialog
            (title: Text("Please Pick an Image") ,
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Okay"))
            ],));
      return;
    }
    if( AuthForm._key.currentState==null ||  !AuthForm._key.currentState!.validate())return ;
    AuthForm._key.currentState!.save();
    setState(() {
      isLoading=true;
    });
    widget.submitFunction(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _pickedImage,
        isLogin);
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child:CircularProgressIndicator())  : Center(
        child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Padding(
              child: Form(
                key: AuthForm._key,
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!isLogin)UserImagePicker(_imagePickerFunction),
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (String ?value){
                      _userEmail=value!;
                    },
                    validator:( value){
                      if(value==null || value.isEmpty==true || !value.contains('@'))return "Please Enter a Valid Email";
                      return null;
                    },
                    decoration: InputDecoration(label: Text('Email Address')),
                  ),
                  if(!isLogin)
                    TextFormField(
                      key:ValueKey('username'),
                      onSaved: (String ?value){
                        _userName=value!;
                      },
                      validator:(value){
                        if(value==null || value.isEmpty)return "User name cannot be empty";
                        return null;
                      },
                      decoration: InputDecoration(label: Text('User Name'))),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (String ? value){
                      _userPassword=value!;
                    },
                    validator: (value){
                      if(value==null ||  value.isEmpty || value.length<6)return "Password is too short";
                      return null;
                    },
                      obscureText: true,
                      decoration:const InputDecoration(label: Text('Password'))),
                 const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                     onPressed: (){
                   _trySubmit(context);
                 }, child: isLogin ? Text("Login") : Text("Sign Up")),
                  const SizedBox(
                    height: 12,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin=!isLogin;
                        });
                      }, child: isLogin? Text("Create a new Account"): Text("I Already have an Account")  )
                ],
              )),
              padding: EdgeInsets.all(16),
            ))));
  }
}
