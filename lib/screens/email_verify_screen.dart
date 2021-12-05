import 'package:flutter/material.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:monochat/screens/chat_screen.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentUserDao currentUserDao = Provider.of<CurrentUserDao>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email verification'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        children: [
          Text(
              '${currentUserDao.email()} is not verified yet. Verify your email to continue using the app.'),
          const SizedBox(
            height: 50,
          ),
          StreamBuilder<bool>(
              stream: currentUserDao.checkVerificationStream(),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data!) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (con) => const ChatScreen()));
                    });
                    return const Icon(
                      Icons.verified,
                      size: 100,
                      color: Colors.green,
                    );
                  } else {
                    return Column(
                      children: const [
                        Center(child: CircularProgressIndicator()),
                        SizedBox(height: 20),
                        Text(
                            'A verification link has been sent to your email address.')
                      ],
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
