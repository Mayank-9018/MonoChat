import 'package:flutter/material.dart';
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
  // TODO: Check if using await is right here or not
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
        Provider<CurrentUserDao>(
          create: (_) => CurrentUserDao(),
          lazy: false,
        )
      ],
      builder: (context, child) {
        return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            title: 'MonoChat',
            home: Provider<CurrentUserDao>(
              create: (_) => CurrentUserDao(),
              builder: (context, child) =>
                  Provider.of<CurrentUserDao>(context, listen: false).isLoggedIn()
                      ? const ChatScreen()
                      : const LoginScreen(),
            ));
      },
    );
  }
}
