import 'package:scholar_chat/constants.dart';

class Message {
  final String id;
  final String message;
  Message(this.message, this.id);

  factory Message.fromJson(doc) {
    return Message(
      doc.data().toString().contains(kmessage) ? doc.get(kmessage) : '',
      doc.data().toString().contains('id') ? doc.get('id') : '',
    );
  }
}
