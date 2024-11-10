import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freedom_app/components/text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Edit $field",
              ),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      if (newValue.trim().length > 0) {
                        await usersCollection
                            .doc(currentUser.email)
                            .update({field: newValue});
                      }
                    },
                    child: Text('Save')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    const SizedBox(height: 50),
                    Icon(
                      Icons.person,
                      size: 72,
                      color: Colors.green,
                    ),
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'My Details',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    MyTextBox(
                      text: userData['username'],
                      sectionName: 'username',
                      onPressed: () => editField('username'),
                    ),
                    MyTextBox(
                      text: userData['bio'],
                      sectionName: 'bio',
                      onPressed: () => editField('bio'),
                    ),
                    MyTextBox(
                      text: userData['phone'],
                      sectionName: 'phone number',
                      onPressed: () => editField('phone'),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error ${snapshot.error}'));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
