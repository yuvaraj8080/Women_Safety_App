import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../Constants/Utils.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  const MessageTextField(
      {super.key, required this.currentId, required this.friendId});

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  Position? _curentPosition;
  String? _curentAddress;
  String? message;
  File? imageFile;
  LocationPermission? permission;
  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((XFile? xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future getImageFromCamera() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.camera).then((XFile? xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
    var uploadTask = await ref.putFile(imageFile!);
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      await sendMessage(imageUrl, 'img');
    }
  }

  Future _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Utils().showError("Location permissions are denied");
      if (permission == LocationPermission.deniedForever) {
        Utils().showError("Location permissions are permanently denied");
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Utils().showError(e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Utils().showError(e.toString());
    }
  }

  sendMessage(String message, String type) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.currentId)
        .collection('messages')
        .doc(widget.friendId)
        .collection('chats')
        .add({
      'senderId': widget.currentId,
      'receiverId': widget.friendId,
      'message': message,
      'type': type,
      'date': DateTime.now(),
    });
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.friendId)
        .collection('messages')
        .doc(widget.currentId)
        .collection('chats')
        .add({
      'senderId': widget.currentId,
      'receiverId': widget.friendId,
      'message': message,
      'type': type,
      'date': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                cursorColor: Colors.pink,
                controller: _controller,
                decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: const TextStyle(color: Colors.black87),
                    fillColor: Colors.black87,
                    filled: true,
                    prefixIcon: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => bottomsheet(),
                          );
                        },
                        icon: const Icon(
                          Icons.add_box_rounded,
                          color: Colors.pink,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  message = _controller.text;
                  sendMessage(message!, 'text');
                  _controller.clear();
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.pink,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomsheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            chatsIcon(Icons.location_pin, "location", () async {
              await _getCurrentLocation();
              Future.delayed(const Duration(seconds: 2), () {
                message =
                    "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";
                sendMessage(message!, "link");
              }).onError((error, stackTrace) {
                Utils().showError(error.toString());
              });
            }),
            chatsIcon(Icons.camera_alt, "Camera", () async {
              await getImageFromCamera();
            }),
            chatsIcon(Icons.insert_photo, "Photo", () async {
              await getImage();
            }),
          ],
        ),
      ),
    );
  }

  chatsIcon(IconData icons, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pink,
            child: Icon(icons, size: 35),
          ),
          Text("$title")
        ],
      ),
    );
  }
}
