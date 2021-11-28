import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:provider/provider.dart';

class UserImage extends StatelessWidget {
  const UserImage(this.uid, {Key? key, this.radius}) : super(key: key);
  final double? radius;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        initialData: null,
        future: getPhotoUrl(context),
        builder: (con, snapshot) {
          return CircleAvatar(
            radius: radius ?? 20,
            backgroundColor: Colors.grey[200],
            foregroundImage: snapshot.data != null
                ? CachedNetworkImageProvider(snapshot.data!)
                : null,
            child: snapshot.data != null
                ? null
                : Icon(
                    Icons.person,
                    size: radius != null ? 80.0 : 24.0,
                    color: Colors.black,
                  ),
          );
        });
  }

  Future<String?> getPhotoUrl(BuildContext context) async {
    Map<String, dynamic> data =
        await Provider.of<UserDao>(context, listen: false).getUserData(uid!);
    return data['photoUrl'];
  }
}
