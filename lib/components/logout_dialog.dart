import 'package:flutter/material.dart';
import 'package:monochat/models/currentUser_dao.dart';
import 'package:monochat/screens/login_screen.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm logout?'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<CurrentUserDao>(context,listen: false).logout();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (con) => const LoginScreen()),
                (route) => false);
          },
          child: const Text('LOGOUT'),
        ),
      ],
    );
  }
}
