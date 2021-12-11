import 'package:flutter/material.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:monochat/screens/chat_screen.dart';
import 'package:monochat/screens/email_verify_screen.dart';
import 'package:monochat/screens/password_reset_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final CurrentUserDao currentUserDao;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentUserDao = Provider.of<CurrentUserDao>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 120, bottom: 25),
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
          TextFormField(
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
            validator: (text) {
              if (text == null ||
                  text.trim() == '' ||
                  !RegExp(r'.+@.+\..+').hasMatch(text.trim())) {
                return 'Invalid email address!';
              } else {
                return null;
              }
            },
            onEditingComplete: login,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
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
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              width: 1.5))),
                  validator: (text) {
                    if (text == null ||
                        text.trim() == '' ||
                        text.trim().length < 8) {
                      return 'Invalid password!';
                    } else {
                      return null;
                    }
                  },
                  onEditingComplete: login),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (con) => PasswordResetScreen()));
                },
                child: const Text(
                  'Forgot password',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: login,
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () => login(signUp: true),
            child: const Text('Create new account'),
          ),
        ],
      ),
    ));
  }

  void login({bool signUp = false}) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0)),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
      try {
        if (signUp) {
          await currentUserDao.signup(
              _emailController.text, _passwordController.text);
        } else {
          await currentUserDao.login(
              _emailController.text, _passwordController.text);
        }
        if (Provider.of<CurrentUserDao>(context, listen: false).isVerified()) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (con) => const ChatScreen()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (con) => const EmailVerificationScreen()),
              (route) => false);
        }
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating, content: Text(e.toString())));
      }
    }
  }
}
