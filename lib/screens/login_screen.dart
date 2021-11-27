import 'package:flutter/material.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:monochat/screens/chat_screen.dart';
import 'package:provider/provider.dart';

//TODO: Have textfield validation

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final UserDao userDao;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    userDao = Provider.of<UserDao>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 40, right: 40, top: 120, bottom: 25),
      children: [
        Image.asset(
          Theme.of(context).brightness == Brightness.light
              ? 'assets/mono_logo_black.png'
              : 'assets/mono_logo_white.png',
          height: 100,
        ),
        const SizedBox(
          height: 25,
        ),
        Center(
          child: Text(
            'MonoChat',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 60),
        TextField(
          controller: _emailController,
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyText1,
              labelText: 'Email Address',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      width: 1.5))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _passwordController,
          autofocus: false,
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyText1,
              labelText: 'Password',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      width: 1.5))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            // userDao.login(_emailController.text, _passwordController.text);
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (con) => ChatScreen()));
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Create new account'),
        ),
      ],
    ));
  }
}
