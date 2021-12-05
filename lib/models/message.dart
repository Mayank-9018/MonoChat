import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime date;
  final String uid;

  DocumentReference? reference;

  Message({required this.text, required this.date, required this.uid});

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
      text: json['text'] as String,
      date: json['timeStamp'].toDate(),
      uid: json['uid'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'timeStamp': FieldValue.serverTimestamp(),
        'text': text,
        'uid': uid
      };

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
