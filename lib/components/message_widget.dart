import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class MessageWidget extends StatelessWidget {
  final String message;
  final DateTime date;
  final String uid;
  final bool fromUser;

  const MessageWidget(this.message, this.date, this.uid,
      {Key? key, this.fromUser = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.white
              ].elementAt(Random().nextInt(5)),
            ),
            const SizedBox(
              width: 5,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(message),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 55),
          child: Text(
            DateFormat(date.isSameDate(DateTime.now())
                        ? 'h:mm a'
                        : 'LLL d • h:mm a')
                    .format(date)
                    .toString() +
                " • $uid",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        )
      ],
    );
  }
}
