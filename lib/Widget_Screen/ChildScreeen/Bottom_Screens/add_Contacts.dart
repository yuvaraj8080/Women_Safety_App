import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Constants/Utils.dart';
import '../../../Constants/contactsm.dart';
import '../../../DB/db_services.dart';
import 'Contacts.Screen.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({Key? key}) : super(key: key);

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  void showList() async {
    try {
      final database = await databasehelper.initializeDatabase();
      final contactList = await databasehelper.getContactList();
      setState(() {
        this.contactList = contactList;
        this.count = contactList?.length ?? 0;
      });
    } catch (error) {
      print("Error fetching contacts: $error");
      Utils().showError("Failed to load contacts");
    }
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Utils().showError("Contact removed successfully");
      showList();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      showList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = [];
    }
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactsPage(),
                  ),
                );
                if (result == true) {
                  showList();
                }
              },
              child: Container(
                color: Colors.white38,
                height: 45,
                width: double.infinity,
                child: Card(
                  elevation: 3,
                  shadowColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80, top: 6),
                    child: Text(
                      "Add Trusted Contacts",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Trusted Contact List ...",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Divider(height: 5, color: Colors.white54, thickness: 2),
            Expanded(
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.black87,
                    elevation: 2,
                    shadowColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(contactList![index].name ?? ""),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      contactList![index].number ?? "");
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteContact(contactList![index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
