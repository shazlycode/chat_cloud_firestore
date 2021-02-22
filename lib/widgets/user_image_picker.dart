import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedI) imagePick;
  UserImagePicker(this.imagePick);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final takenImage = await picker.getImage(
        source: ImageSource.camera, maxHeight: 150, imageQuality: 50);
    setState(() {
      _pickedImage = File(takenImage.path);
    });
    widget.imagePick(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        FlatButton.icon(
            onPressed: () {
              _pickImage();
            },
            icon: Icon(Icons.image),
            label: Text('Take Image'))
      ],
    );
  }
}
