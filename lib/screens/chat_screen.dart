import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monochat/components/user_image.dart';
import 'package:monochat/models/message.dart';
import 'package:monochat/models/message_dao.dart';
import 'package:monochat/models/current_user_dao.dart';
import 'package:monochat/screens/changelog_screen.dart';
import 'package:monochat/screens/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monochat/components/message_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final CurrentUserDao currentUserDao;
  late final MessageDao messageDao;

  @override
  void initState() {
    super.initState();
    currentUserDao = Provider.of<CurrentUserDao>(context, listen: false);
    messageDao = Provider.of<MessageDao>(context, listen: false);
    checkChangelog();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  CupertinoPageRoute<bool>(
                    builder: (BuildContext context) => const UserScreen(),
                  ));
            },
            borderRadius: BorderRadius.circular(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: UserImage(currentUserDao.userId()),
            ),
          ),
        ],
        title: const Text('MonoChat'),
      ),
      body: Column(
        children: [
          _getMessageList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              minLines: 1,
              maxLines: 6,
              keyboardType: TextInputType.text,
              controller: _messageController,
              onSubmitted: (input) {
                _sendMessage(messageDao);
              },
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    child: const Icon(Icons.send),
                    onTap: () => _sendMessage(messageDao),
                  ),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  filled: true,
                  hintText: 'Enter new message'),
            ),
          ),
        ],
      ),
    );
  }

  bool _canSendMessage() => _messageController.text.isNotEmpty;

  void _sendMessage(MessageDao messageDao) {
    if (_canSendMessage()) {
      final message = Message(
          text: _messageController.text,
          date: DateTime.now(),
          uid: currentUserDao.userId() as String);
      messageDao.saveMessage(message);
      _messageController.clear();
      scrollToBottom();
      setState(() {});
    }
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.minScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _getMessageList() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: messageDao.getMessageStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildList(context, snapshot.data!.docs);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView.separated(
        controller: _scrollController,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemBuilder: (context, ind) => _buildListItem(context, snapshot![ind]),
        separatorBuilder: (con, ind) => const SizedBox(
              height: 8,
            ),
        itemCount: snapshot!.length);
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final message = Message.fromSnapshot(snapshot);
    return MessageWidget(message.text, message.date, message.uid);
  }

  void checkChangelog() async {
    String version = jsonDecode(
        await rootBundle.loadString('assets/changelog.json'))['version'];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('change_$version') == null ||
        sharedPreferences.getBool('change_$version') == false) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (con) => const ChangelogScreen()));
    }
  }
}
