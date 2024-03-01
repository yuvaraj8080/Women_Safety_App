import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_women_safety_app/utils/constants/sizes.dart';
import 'package:flutter_women_safety_app/utils/halpers/helper_function.dart';

import '../../../Constants/Utils.dart';
import '../../../Constants/contactsm.dart';
import '../../../DB/db_services.dart';
import '../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../../utils/constants/colors.dart';
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
      TLoaders.successSnackBar(title:"Contact removed successfully");
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
              child:Card(
                child: Container(
                  width:double.infinity,
                    child: Center(child: Text("Add Trusted contacts",style:Theme.of(context).textTheme.headlineMedium))),
              ),
            ),

            Divider(height:2,color:THelperFunction.isDarkMode(context)?TColors.darkGrey:TColors.light),
            Text(
              "Trusted Contact List...",style:Theme.of(context).textTheme.bodyMedium),
            SizedBox(height:TSizes.size4,),
            Divider(height: 5, color: THelperFunction.isDarkMode(context)?Colors.white:Colors.black,thickness: 2),
            SizedBox(height:TSizes.size4,),
            Expanded(
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: THelperFunction.isDarkMode(context)?TColors.light:TColors.grey,
                    elevation: 2,
                    shadowColor: THelperFunction.isDarkMode(context)?TColors.light:TColors.grey,
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
