import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage(this.photoUrl, {Key? key, this.radius})
      : hasPhoto = photoUrl != null && photoUrl != '',
        super(key: key);
  final double? radius;
  final String? photoUrl;
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 20,
      backgroundColor: hasPhoto ? Colors.grey[300] : Colors.grey,
      foregroundImage: hasPhoto ? CachedNetworkImageProvider(photoUrl!) : null,
      child: hasPhoto
          ? null
          : Icon(
              Icons.person,
              size: radius != null ? 80.0 : 24.0,
              color: Colors.black,
            ),
    );
  }
}
