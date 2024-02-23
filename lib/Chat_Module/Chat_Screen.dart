import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Constants/Utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Constants.dart';
import 'Message_TextField.dart';
import 'SingleMessage.dart';

class ChattingScreen extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;

  const ChattingScreen({
    Key? key,
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
  }) : super(key: key);

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  String? type;
  String? myname;

  Future<void> getStatus() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.currentUserId)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data();
        setState(() {
          type = userData?['type'];
          myname = userData?['name'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(widget.friendName,style:GoogleFonts.lato(fontSize:18),),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(widget.currentUserId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .collection('chats')
                  .orderBy('date', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        type == "parent"
                            ? "TALK WITH CHILD"
                            : "TALK WITH GUARDIAN",
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isMe =
                            snapshot.data!.docs[index]['senderId'] ==
                                widget.currentUserId;
                        final data = snapshot.data!.docs[index];
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(widget.currentUserId)
                                .collection('messages')
                                .doc(widget.friendId)
                                .collection('chats')
                                .doc(data.id)
                                .delete();
                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(widget.friendId)
                                .collection('messages')
                                .doc(widget.currentUserId)
                                .collection('chats')
                                .doc(data.id)
                                .delete()
                                .then((value) => Utils().showError('message deleted'));
                          },
                          child: SingleMessage(
                            message: data['message'],
                            date: data['date'],
                            isMe: isMe,
                            friendName: widget.friendName,
                            myName: myname ??'',
                            type: data['type'],
                          ),
                        );
                      },
                    ),
                  );
                }
                return progressIndicator(context);
              },
            ),
          ),
          MessageTextField(
            currentId: widget.currentUserId,
            friendId: widget.friendId,
          ),
        ],
      ),
    );
  }
}
