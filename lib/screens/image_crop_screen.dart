import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:provider/provider.dart';

class ImageCropScreen extends StatelessWidget {
  final String uid;
  final Uint8List imageData;
  final CropController _cropController = CropController();

  ImageCropScreen(this.uid, this.imageData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Crop(
        controller: _cropController,
        initialSize: 0.7,
        image: imageData,
        onCropped: (data) {
          Stream<TaskSnapshot> taskStream =
              Provider.of<UserDao>(context, listen: false)
                  .updateImage(context, uid, data);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (con) => WillPopScope(
                    onWillPop: () async => false,
                    child: SimpleDialog(
                      children: [
                        StreamBuilder<TaskSnapshot>(
                            stream: taskStream,
                            builder: (con, snap) {
                              if (snap.hasData) {
                                if (snap.data!.state != TaskState.success) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Center(
                                      child: Text(
                                    'Upload Complete!',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ));
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                      ],
                    ),
                  ));
        },
        aspectRatio: 1.0,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                _cropController.crop();
              },
              child: const Text('Done')),
        ],
      ),
    );
  }
}
