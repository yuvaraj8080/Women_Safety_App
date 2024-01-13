
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleMessage extends StatelessWidget {
  final String? message;
  final bool? isMe;
  final String? image;
  final String? type;
  final String? friendName;
  final String? myName;
  final Timestamp? date;

  const SingleMessage({
    Key? key,
    this.message,
    this.isMe,
    this.image,
    this.type,
    this.friendName,
    this.myName,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    DateTime? d;
    String? cdate;
    if (date != null) {
      d = DateTime.parse(date!.toDate().toString());
      cdate = "${d.hour}" + ":" + "${d.minute}";
    }

    return type == "text"
        ? Container(
      // color:Colors.green,
      constraints: BoxConstraints(
        maxWidth: size.width /1,
      ),
      alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: isMe! ? Colors.greenAccent.shade200 : Colors.white70,
          borderRadius: isMe!
              ? const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: size.width /1.4,
        ),
        alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          children: [
            isMe! ?
            Align(
              alignment: Alignment.centerRight,
              child: Text(message ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.black),),)
            :Align(
              alignment: Alignment.centerLeft,
              child: Text(message ?? '', style: const TextStyle(fontSize: 15, color: Colors.black),),),


            isMe! ?
            Align(
              alignment: Alignment.centerRight,
              child: Text(cdate ?? '',style: const TextStyle(fontSize: 12, color: Colors.black54)))
                :
            Align(
                alignment: Alignment.centerLeft,
                child: Text(cdate ?? '',style: const TextStyle(fontSize: 12, color: Colors.black54)))
          ],
        ),
      ),
    )
        : type == 'img'
        ? Container(
      height: size.height / 2.5,
      width: size.width,
      alignment:
      isMe! ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(5),
      child: Container(
        height: size.height / 2.5,
        width: size.width,
        decoration: BoxDecoration(
          color: isMe! ? Colors.pink : Colors.black,
          borderRadius: isMe!
              ? const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: size.width / 2,
        ),
        alignment:
        isMe! ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          children: [

            CachedNetworkImage(
              imageUrl: message ?? '',
              fit: BoxFit.cover,
              height: size.height / 3.62,
              width: size.width,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                cdate ?? '',
                style:
                const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    )
        : Container(
      constraints: BoxConstraints(
        maxWidth: size.width / 2,
      ),
      alignment:
      isMe! ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: isMe! ? Colors.greenAccent.shade200 : Colors.white70,
          borderRadius: isMe!
              ? const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(5),
        constraints: BoxConstraints(
          maxWidth: size.width /1.4,
        ),
        alignment:
        isMe!
            ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                isMe! ? myName! : friendName!,
                style:
                const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse("$message"));
                },
                child: Text(
                  message ?? '',
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Colors.blue),
                ),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                cdate ?? '',
                style:
                const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
