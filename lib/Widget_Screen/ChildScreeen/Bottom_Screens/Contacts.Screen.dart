import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Constants/contactsm.dart';
import '../../../DB/db_services.dart';


class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }
  filterContact() {
    List<Contact> _contacts = contacts.toList(); // Create a copy of contacts

    if (searchController.text.isNotEmpty) {
      String searchTerm = searchController.text.toLowerCase();
      String searchTermFlattren = flattenPhoneNumber(searchTerm);

      _contacts.retainWhere((element) {
        // Handle potential nulls in displayName and phones
        String contactName = element.displayName?.toLowerCase() ?? '';
        var matchingPhone = element.phones?.firstWhereOrNull((p) { // Using firstWhereOrNull correctly
          return flattenPhoneNumber(p.value ?? '').contains(searchTermFlattren);
        });

        // Prioritize name match
        if (contactName.contains(searchTerm)) {
          return true;
        }

        // Check for phone match only if searchTerm is a valid phone number
        if (searchTermFlattren.isNotEmpty && matchingPhone != null) {
          return true;
        }

        return false;
      });
    }

    setState(() {
      contactsFiltered = _contacts;
    });
  }



  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContact();
      });
    } else {
      handInvaliedPermissions(permissionStatus);
    }
  }

  handInvaliedPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      // Utils().showError("Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      // Utils().showError("May contact does exist in this device");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts =
    await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchIng = searchController.text.isNotEmpty;
    bool listItemExit = (contactsFiltered.length > 0 || contacts.length > 0);
    return Scaffold(
      body: contacts.length == 0
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:5),
              child: Container(
                color:Colors.white38,
                height:70,width:double.infinity,
                child: Card(
                  elevation:3,shadowColor:Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8,right:8),
                    child: TextField(
                      controller: searchController,
                      decoration:  const InputDecoration(
                          labelText: "Search Contact",
                          prefixIcon: Icon(Icons.search,color:Colors.pinkAccent,)),
                    ),
                  ),
                ),
              ),
            ),
            listItemExit == true
                ? Expanded(
              child: ListView.builder(

                itemCount: isSearchIng == true
                    ? contactsFiltered.length
                    : contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact contact = isSearchIng == true
                      ? contactsFiltered[index]
                      : contacts[index];
                  return Card(
                    color:Colors.black87,
                    elevation:2,shadowColor: Colors.white,
                    child: ListTile(
                      title: Text(contact.displayName ?? 'No Name'),
                      subtitle: Text(contact.phones!.isNotEmpty
                          ? contact.phones!.elementAt(0).value ?? 'No Phone Number'
                          : 'No Phone Number'),
                      leading: contact.avatar != null &&
                          contact.avatar!.length > 0
                          ? CircleAvatar(
                        backgroundColor:Colors.pinkAccent.shade200,
                        backgroundImage:
                        MemoryImage(contact.avatar!),
                      )
                          : CircleAvatar(
                        backgroundColor: Colors.pinkAccent.shade200,
                        child: Text(contact.initials()),
                      ),
                      onTap: () {
                        if (contact.phones!.length > 0) {
                          final String phoneNum =
                          contact.phones!.elementAt(0).value!;
                          final String name = contact.displayName!;
                          _addContact(TContact(phoneNum, name));
                        } else {
                          // Utils().showError(
                          //     "Oops! phone number of this contact does exist");
                        }
                      },
                    ),
                  );
                },
              ),
            )
                : Container(
              child: const Text("searching"),
            ),
          ],
        ),
      ),
    );
  }

  void _addContact(TContact newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      // Utils().showError("contact added successfully");
    }
    else {
      // Utils().showError("Failed to add contacts");
    }
    Navigator.of(context).pop(true);
  }


}
