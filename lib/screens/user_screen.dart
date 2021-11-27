import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monochat/components/logout_dialog.dart';
import 'package:monochat/components/user_image.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final CurrentUserDao currentUserDao;
  @override
  void initState() {
    super.initState();
    currentUserDao = Provider.of<CurrentUserDao>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showDialog(
                context: context, builder: (con) => const LogoutDialog()),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 40,
          ),
          Hero(
              tag: currentUserDao.userId()!,
              child: UserImage(
                currentUserDao.photoUrl(),
                radius: 100,
              )),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            textAlign: TextAlign.center,
            initialValue:
                (currentUserDao.name() ?? "").isNotEmpty ? currentUserDao.name()! : 'No Name',
            style: Theme.of(context).textTheme.headline4,
            decoration: const InputDecoration(border: InputBorder.none),
            onFieldSubmitted: (text) => currentUserDao.updateName(text),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: Text(currentUserDao.email()!),
            subtitle: const Text('Email address'),
            trailing: const Tooltip(
              message: 'Email Verified!',
              child: Icon(
                Icons.verified,
                color: Colors.green,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(DateFormat('d LLLL y').format(currentUserDao.creationDate()!)),
            subtitle: const Text('Account creation date'),
          ),
        ],
      ),
    );
  }
}
