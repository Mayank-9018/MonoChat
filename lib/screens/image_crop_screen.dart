import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class ImageCropScreen extends StatelessWidget {
  final Uint8List imageData;

  const ImageCropScreen(this.imageData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Crop(
        initialSize: 0.7,
        image: imageData,
        onCropped: (data) {},
        aspectRatio: 1.0,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          TextButton(onPressed: () {}, child: const Text('Done')),
        ],
      ),
    );
  }
}
