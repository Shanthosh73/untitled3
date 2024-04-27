import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/resultimage.dart';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final image = File(pickedImage.path);
      setState(() {
        _image = image;
      });
      if (_image != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultImagesPage(_image!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image == null)
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              )
            else
              Image.file(_image!),
          ],
        ),
      ),
    );
  }
}
