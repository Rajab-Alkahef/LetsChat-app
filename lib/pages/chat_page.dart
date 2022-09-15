import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/model/message.dart';

import '../widgets/custom_chat_bubble.dart';

class chatPage extends StatelessWidget {
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagescollection);

  TextEditingController controller = TextEditingController();
  static String id = 'chatPage';
  String? send;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Image.asset(
                      klogo,
                      height: 40,
                    ),
                  ),
                  Text('Chat')
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: ((context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(
                              message: messageList[index],
                            )
                          : ChatBubbleOfFriends(message: messageList[index]);
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onChanged: ((data) {
                      send = data;
                    }),
                    onSubmitted: ((data) {
                      messages.add({
                        kmessage: data,
                        kcreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(seconds: 1), curve: Curves.ease);
                    }),
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      hintStyle: TextStyle(
                        color: kPrimaryColor,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            messages.add({
                              kmessage: send,
                              kcreatedAt: DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                            _controller.animateTo(0,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          },
                          icon: Icon(Icons.send, color: kPrimaryColor)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading....');
        }
      }),
    );
  }
}
