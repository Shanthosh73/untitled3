import 'package:flutter/material.dart';
import 'package:untitled3/uploadimage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaceSearch App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadImagePage()),
            );
          },
          child: Text('Upload Image'),
        ),
      ),
    );
  }
}
