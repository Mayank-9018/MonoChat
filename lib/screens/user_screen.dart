import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserDao userdao;
  @override
  void initState() {
    super.initState();
    userdao = Provider.of<UserDao>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundImage: userdao.photoUrl() == null
                  ? null
                  : CachedNetworkImageProvider(userdao.photoUrl()!),
              backgroundColor: userdao.photoUrl() != null
                  ? Colors.grey[400]
                  : Colors.deepPurple[300],
              radius: 100,
            ),
            Text(
              (userdao.name() ?? "").isNotEmpty ? userdao.name()! : 'No Name',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(userdao.email()!),
            Text(DateFormat('d LLLL y').format(userdao.creationDate()!))
          ],
        ),
      ),
    );
  }
}
