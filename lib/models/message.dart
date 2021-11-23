import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //TODO: Replace date by timestamp
  final String text;
  final DateTime date;
  final String? email;
  final FieldValue timeStamp = FieldValue.serverTimestamp();

  DocumentReference? reference;

  Message({required this.text, required this.date, this.email});

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      email: json['email'] as String?);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'date': date.toString(), 'text': text, 'email': email};

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
