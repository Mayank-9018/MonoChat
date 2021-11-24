import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monochat/models/message_dao.dart';
import 'package:monochat/screens/chat_screen.dart';
import 'package:provider/provider.dart';

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
          lazy: false,
          create: (__) => MessageDao(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          cardColor: Colors.grey.shade200,
        ),
        darkTheme: ThemeData.dark(),
        title: 'MonoChat',
        home: const ChatScreen(),
      ),
    );
  }
}
