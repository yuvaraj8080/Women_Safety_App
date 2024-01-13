import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Componants_Widget/customText_Button.dart';
import 'package:flutter_women_safety_app/Componants_Widget/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Utils.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController locationC = TextEditingController();
  TextEditingController viewsC = TextEditingController();
  bool isSaving = false;

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Review your place"),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: CustomTextField(
                    hintText: 'enter location',
                    controller: locationC,
                  ),
                ),
                CustomTextField(
                  controller: viewsC,
                  hintText: 'About this Place',
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            customTextButton(
              title: "SAVE",
              onPressed: () {
                saveReview();
                locationC.clear();
                viewsC.clear();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  saveReview() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance.collection('reviews').add({
      'location': locationC.text,
      'views': viewsC.text,
    }).then((value) {
      setState(() {
        isSaving = false;
        Utils().showError("review uploaded successfully");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REVIEW PAGE",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink,
        elevation: 3,
        shadowColor: Colors.white,
        actions: [const Icon(Icons.star_purple500_sharp, color: Colors.white)],
      ),
      body: isSaving == true
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder(
        stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final data = snapshot.data!.docs[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  setState(() {
                    FirebaseFirestore.instance.collection('reviews').doc(data.id).delete().then((value){
                      Utils().showError("Deleted Successfully");
                    });
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Card(
                    color: Colors.black87,
                    elevation: 2,
                    shadowColor: Colors.white,
                    child: ListTile(
                      title: Text(
                        data['location'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      subtitle: Text(
                        data['views'],
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () {
            showAlert(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
