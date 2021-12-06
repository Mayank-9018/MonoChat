import 'package:flutter/material.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatelessWidget {
  PasswordResetScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
        // centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        physics: const BouncingScrollPhysics(),
        children: [
          Image.asset(
            'assets/password.png',
            height: 75,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
              'A password reset link will be sent to your email address.'),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: _formKey,
              child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      labelText: 'Email Address',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              width: 1.5))),
                  validator: (text) {
                    if (text == null ||
                        text.trim() == '' ||
                        !RegExp(r'.+@.+\..+').hasMatch(text.trim())) {
                      return 'Invalid email address!';
                    } else {
                      return null;
                    }
                  })),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  sendResetLink(context);
                }
              },
              child: const Text('Confirm'))
        ],
      ),
    );
  }

  Future<void> sendResetLink(BuildContext context) async {
    try {
      await Provider.of<CurrentUserDao>(context, listen: false)
          .sendPasswordReset(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Check your inbox for password reset link.')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
