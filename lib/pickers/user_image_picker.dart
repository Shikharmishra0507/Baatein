import 'dart:io'; // at beginning of file

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {

  UserImagePicker(this.imagePickerFunction);
  final void Function (File ?pickedImage) imagePickerFunction;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File ?image;
  void _pickImage() async{
    final picker = ImagePicker();
    final pickedImage = await
    picker.pickImage(
        source: ImageSource.camera,
    imageQuality: 50,
    maxWidth: 150);
    if(pickedImage!=null){
      setState(() {
        image = File(pickedImage.path);
      });

    }
    widget.imagePickerFunction(image);
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: image==null ? null :FileImage(image!),
      ),
      IconButton(onPressed: _pickImage

      , icon:Icon(Icons.image_search))
    ],);
  }
}
