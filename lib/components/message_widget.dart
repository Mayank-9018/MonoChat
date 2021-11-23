import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//TODO: Show time and date inside the message itseld something like AOSP messages or below the message like Google Messages
class MessageWidget extends StatelessWidget {
  final String message;
  final DateTime date;
  final String? email;
  final bool fromUser;

  const MessageWidget(this.message, this.date, this.email,
      {Key? key, this.fromUser = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (fromUser)
          Row(
            children: [
              Text(
                DateFormat('h:mm a').format(date).toString(),
                style: const TextStyle(color: Colors.grey),
                //TODO: Instead of defining textstyles individually, utilise Themes
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft:
                      fromUser ? const Radius.circular(15) : Radius.zero,
                  bottomRight:
                      fromUser ? Radius.zero : const Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        if (!fromUser)
          Row(
            children: [
              Text(
                DateFormat('h:mm a').format(date).toString(),
                style: const TextStyle(color: Colors.grey),
                //TODO: Instead of defining textstyles individually, utilise Themes
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
      ],
    );
  }
}
