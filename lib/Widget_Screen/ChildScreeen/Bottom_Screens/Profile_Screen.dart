import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_women_safety_app/Componants_Widget/customText_Button.dart';
import 'package:flutter_women_safety_app/Componants_Widget/custom_textfield.dart';
import 'package:flutter_women_safety_app/Constants/Constants.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ChildScreeen/Child_Login_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../Constants/PrimaryButton.dart';
import '../../../Constants/Utils.dart';

class CheckUserStatusBeforeChatOnProfile extends StatelessWidget {
  const CheckUserStatusBeforeChatOnProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return const ProfilePage();
          } else {
            Fluttertoast.showToast(msg: 'Please login first');
            return Login();
          }
        }
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameC = TextEditingController();
  final key = GlobalKey<FormState>();
  String? id;
  String? profilePic;
  String? downloadUrl;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // Dispose of resources, cancel ongoing operations
    // Your cleanup code here
    super.dispose();
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          nameC.text = value.docs.first['name'];
          id = value.docs.first.id;
          profilePic = value.docs.first['profilePic'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY PROFILE",style:TextStyle(fontSize:18,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
        elevation: 2,
        shadowColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(),
            ),
            ListTile(
              title: customTextButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    goTo(context, Login());
                  } on FirebaseAuthException catch (e) {
                    Utils().showError(e.toString());
                  }
                },
                title: 'Sign Out',
              ),
            )
          ],
        ),
      ),
      body: isSaving == true
          ? progressIndicator(context)
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      final XFile? pickedImage = await ImagePicker()
                          .pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50);
                      if (pickedImage != null) {
                        if (mounted) {
                          setState(() {
                            profilePic = pickedImage.path;
                          });
                        }
                      }
                    },
                    child: Container(
                      child: profilePic == null
                          ? CircleAvatar(
                        backgroundColor:
                        Colors.pinkAccent.shade200,
                        radius: 70,
                        child: Center(
                          child: Image.asset(
                            'assets/images/add_pic.png',
                            height: 60,
                            width: 60,
                          ),
                        ),
                      )
                          : profilePic!.contains('http')
                          ? CircleAvatar(
                        backgroundColor:
                        Colors.deepPurple,
                        radius: 70,
                        backgroundImage:
                        NetworkImage(profilePic!),
                      )
                          : CircleAvatar(
                        backgroundColor:
                        Colors.deepPurple,
                        radius: 70,
                        backgroundImage: FileImage(
                          File(profilePic!),
                        ),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: nameC,
                    hintText: nameC.text,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter your updated name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  PrimaryButton(
                    title: "UPDATE PROFILE",
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        SystemChannels.textInput.invokeMethod(
                            'TextInput.hide');
                        if (profilePic == null) {
                          Utils().showError(
                              'Please select a profile picture');
                        } else {
                          update();
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImage(String filePath) async {
    try {
      final fileName = const Uuid().v4();
      final Reference fbStorage = FirebaseStorage.instance
          .ref('profile')
          .child(fileName);
      final UploadTask uploadTask = fbStorage.putFile(File(filePath));
      await uploadTask.then((p0) async {
        downloadUrl = await fbStorage.getDownloadURL();
      });
      return downloadUrl;
    } catch (e) {
      Utils().showError(e.toString());
      return null;
    }
  }

  void update() async {
    setState(() {
      isSaving = true;
    });

    final String? imageUrl = await uploadImage(profilePic!);

    if (imageUrl != null) {
      Map<String, dynamic> data = {
        'name': nameC.text,
        'profilePic': imageUrl,
      };
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }
}
