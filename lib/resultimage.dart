import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultImagesPage extends StatefulWidget {
  final File image;

  ResultImagesPage(this.image);

  @override
  _ResultImagesPageState createState() => _ResultImagesPageState();
}

class _ResultImagesPageState extends State<ResultImagesPage> {
  List<String> _resultImages = [];
  int _currentImageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  Future<void> _getImages() async {
    // Upload image to dummy API
    final uploadRequest =
        await http.post(Uri.parse('http://localhost:8080/upload'));

    if (uploadRequest.statusCode == 200) {
      // Get result images from API
      final imagesResponse =
          await http.get(Uri.parse('http://localhost:8080/images'));
      _resultImages = imagesResponse.body.split('\n');

      // Start showing images one by one every 2 seconds
      _startImageTimer();
    } else {
      // Handle upload error
      print('Image upload failed');
    }
  }

  void _startImageTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _resultImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.file(widget.image),
                if (_resultImages.isNotEmpty)
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Image(
                      image: AssetImage(_resultImages[_currentImageIndex]),
                      key: ValueKey(_currentImageIndex),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
