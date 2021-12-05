import 'package:flutter/material.dart';
import 'package:monochat/models/user_dao.dart';
import 'package:monochat/screens/email_verify_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:monochat/models/message_dao.dart';
import 'package:monochat/screens/login_screen.dart';
import 'package:monochat/screens/chat_screen.dart';
import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MessageDao>(
          create: (_) => MessageDao(),
          lazy: false,
        ),
        Provider<UserDao>(
          create: (_) => UserDao(),
          lazy: false,
        ),
        Provider<CurrentUserDao>(
          create: (context) => CurrentUserDao(context),
          lazy: false,
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          title: 'MonoChat',
          home: Provider.of<CurrentUserDao>(context, listen: false).isLoggedIn()
              ? Provider.of<CurrentUserDao>(context, listen: false).isVerified()
                  ? const ChatScreen()
                  : const EmailVerificationScreen()
              : const LoginScreen(),
        );
      },
    );
  }
}
