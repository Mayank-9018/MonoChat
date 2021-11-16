import 'package:flutter/material.dart';
import 'package:monochat/components/message_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Firebase initialization here
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MonoChat',
      home: MessageList(),
    );
  }
}
