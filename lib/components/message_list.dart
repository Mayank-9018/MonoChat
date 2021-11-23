import 'package:flutter/material.dart';
import 'package:monochat/models/message.dart';
import 'package:monochat/models/message_dao.dart';
import 'package:provider/provider.dart';

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
      bottomSheet: Padding(
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
      body: Column(
        children: [
          _getMessageList(),
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

  Widget _getMessageList() {
    return const SizedBox.shrink();
  }
}
