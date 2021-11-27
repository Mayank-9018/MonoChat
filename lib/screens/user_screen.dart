import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monochat/components/user_image.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:monochat/screens/login_screen.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              userdao.logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (con) => LoginScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Hero(
                tag: userdao.userId()!,
                child: UserImage(
                  userdao.photoUrl(),
                  radius: 100,
                )),
            const SizedBox(
              height: 15,
            ),
            Text(
              (userdao.name() ?? "").isNotEmpty ? userdao.name()! : 'No Name',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text(userdao.email()!),
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
              title:
                  Text(DateFormat('d LLLL y').format(userdao.creationDate()!)),
              subtitle: const Text('Account creation date'),
            ),
          ],
        ),
      ),
    );
  }
}
