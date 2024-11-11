import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freedom_app/components/custom_app_bar.dart';
import 'package:freedom_app/models/job.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? _selectedCardIndex;

  // Sign out the current user
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Open a URL
  Future<void> _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the user's favorite jobs collection from Firestore
    final favoritesCollection = FirebaseFirestore.instance
        .collection('Favorites');

    return Scaffold(
      appBar: GradientAppBar(
        title: const Text('Избранные', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favoritesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('У вас пока нет избранных'));
          }

          final favoriteJobs = snapshot.data!.docs.map((doc) {
            return Job(
              profession: doc['profession'],
              city: doc['city'],
              salary: doc['salary'],
              urls: doc['urls'], conditions: '', relocation: '', gender: '', age: 0, education: [], experience: '', workExperience: [], skills: '',
            );
          }).toList();

          return ListView.builder(
            itemCount: favoriteJobs.length,
            itemBuilder: (context, index) {
              final job = favoriteJobs[index];
              final isSelected = _selectedCardIndex == index;

              return Dismissible(
                key: ValueKey('${job.profession}-${job.city}-${job.salary}'),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  favoritesCollection.doc(snapshot.data!.docs[index].id).delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Вы удалили ${job.profession} из избранных')),
                  );
                },
                background: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    _openUrl(job.urls);
                    setState(() {
                      _selectedCardIndex = isSelected ? null : index;
                    });
                  },
                  child: Card(
                    color: isSelected ? Colors.green[100] : Colors.white,
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(job.profession),
                      subtitle: Text('${job.city} - ${job.salary}'),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Job model class to represent job data