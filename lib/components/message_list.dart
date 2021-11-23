import 'package:flutter/material.dart';
import 'package:monochat/models/message.dart';
import 'package:monochat/models/message_dao.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_widget.dart';

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final TextEditingController _messageController = TextEditingController();
  late final MessageDao messageDao;

  @override
  void initState() {
    super.initState();
    messageDao = Provider.of<MessageDao>(context, listen: false);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MonoChat'),
      ),
      body: Column(
        children: [
          _getMessageList(messageDao),
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
        // TODO: add email
      );
      messageDao.saveMessage(message);
      _messageController.clear();
      setState(() {});
    }
  }

  Widget _getMessageList(MessageDao messageDao) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: messageDao.getMessageStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: LinearProgressIndicator());
          }
          return _buildList(context, snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final message = Message.fromSnapshot(snapshot);
    return MessageWidget(message.text, message.date, message.email);
  }
}
