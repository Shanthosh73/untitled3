import 'dart:io';
import 'dart:math';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

const List<String> _imageUrls = [
  'https://example.com/image1.jpg',
  'https://example.com/image2.jpg',
  'https://example.com/image3.jpg',
  // Add more image URLs here
];

List<String> getRandomImages(int count) {
  final random = Random();
  final images = <String>[];

  for (int i = 0; i < count; i++) {
    images.add(_imageUrls[random.nextInt(_imageUrls.length)]);
  }

  return images;
}

void main(List<String> args) async {
  final server = await serve(_requestHandler, 'localhost', 8080);
  print('Serving at http://${server.address.host}:${server.port}');
}

Future<Response> _requestHandler(Request request) async {
  final path = request.url.path;

  if (path == '/upload') {
    // Simulate image upload
    await Future.delayed(Duration(seconds: 2));
    return Response.ok('Image uploaded successfully');
  } else if (path == '/images') {
    // Return random images
    final images = getRandomImages(10);
    return Response.ok(images.join('\n'));
  } else {
    return Response.notFound('Not found');
  }
}
