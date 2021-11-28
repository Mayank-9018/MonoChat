import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:monochat/models/user_dao.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class MessageWidget extends StatelessWidget {
  final String message;
  final DateTime date;
  final String uid;

  const MessageWidget(
    this.message,
    this.date,
    this.uid, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> userDataFuture = getUserData(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FutureBuilder<Map<String, dynamic>>(
                future: userDataFuture,
                builder: (con, snapshot) {
                  return CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: snapshot.data?['photoUrl'] == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.black,
                          )
                        : null,
                    foregroundImage: snapshot.data?['photoUrl'] == null
                        ? null
                        : NetworkImage(snapshot.data?['photoUrl']),
                  );
                }),
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
            child: FutureBuilder<Map<String, dynamic>>(
                future: userDataFuture,
                builder: (cont, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        DateFormat(date.isSameDate(DateTime.now())
                                    ? 'h:mm a'
                                    : 'LLL d • h:mm a')
                                .format(date)
                                .toString() +
                            " • " +
                            (snapshot.data!['name'] ?? snapshot.data!['email']),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12));
                  } else {
                    return Text(
                        DateFormat(date.isSameDate(DateTime.now())
                                ? 'h:mm a'
                                : 'LLL d • h:mm a')
                            .format(date)
                            .toString(),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12));
                  }
                }))
      ],
    );
  }

  Future<Map<String, dynamic>> getUserData(BuildContext context) async {
    var query =
        await Provider.of<UserDao>(context, listen: false).getUserDate(uid);
    return query.docs.first.data() as Map<String, dynamic>;
  }
}
