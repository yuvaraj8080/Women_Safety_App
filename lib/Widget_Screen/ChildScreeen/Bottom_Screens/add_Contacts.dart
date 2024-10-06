import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ChildScreeen/Bottom_Screens/Contacts.Screen.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/loaders/snackbar_loader.dart';

import 'package:flutter_women_safety_app/utils/constants/sizes.dart';
import 'package:flutter_women_safety_app/utils/halpers/helper_function.dart';
import '../../../Constants/contactsm.dart';
import '../../../DB/db_services.dart';
import '../../../utils/constants/colors.dart';

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
      TLoaders.errorSnackBar(title: "Failed to load contacts");
    }
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      TLoaders.successSnackBar(title: "Contact removed successfully");
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

    bool isDarkMode = THelperFunction.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: isDarkMode ? Colors.black : Colors.white,
                elevation: 5,
                shadowColor:
                    isDarkMode ? Colors.white.withOpacity(0.3) : Colors.black54,
                child: InkWell(
                  onTap: () async {
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
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Add Trusted Contacts",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.add_call,
                          size: 35,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Note: Restart your app after adding trusted contacts.",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Divider(
              height: 5,
              color: isDarkMode ? Colors.white : Colors.black,
              thickness: 3,
            ),
            SizedBox(height: TSizes.size8),
            Expanded(
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    elevation: 2,
                    shadowColor: isDarkMode
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isDarkMode
                            ? Colors.white
                            : Colors.black, // Border color based on theme
                        width: 1, // Border width
                      ),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          contactList![index].name ?? "",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
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
