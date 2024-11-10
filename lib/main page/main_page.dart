import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freedom_app/components/custom_app_bar.dart';
import 'package:freedom_app/main.dart';
import 'package:freedom_app/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? _selectedCardIndex; // Track the index of the currently selected card

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteJobs = favoritesProvider.favorites;

    return Scaffold(
      appBar: GradientAppBar(title: const Text('Избранные', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout, color: Colors.white,),
          ),
        ],),
      body: favoriteJobs.isEmpty
          ? const Center(child: Text('У вас пока нет избранных'))
          : ListView.builder(
              itemCount: favoriteJobs.length,
              itemBuilder: (context, index) {
                final job = favoriteJobs[index];

                // Determine whether the current card is selected
                final isSelected = _selectedCardIndex == index;

                return Dismissible(
                  key: ValueKey('${job.profession}-${job.city}-${job.education}'), // Unique key to identify each job
                  direction: DismissDirection.endToStart, // Swipe from right to left
                  onDismissed: (direction) {
                    // Remove the job from favorites when dismissed
                    favoritesProvider.removeFavorite(job);

                    // Show a snackbar for feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${job.profession} removed from favorites')),
                    );
                  },
                  background: Container(
                    color: Colors.red, // Background color when swiping
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.delete, color: Colors.white), // Delete icon
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Open URL when the card is tapped
                      _openUrl(job.urls);

                      // Update the selected card index
                      setState(() {
                        _selectedCardIndex = isSelected ? null : index;
                      });
                    },
                    child: Card(
                      color: isSelected ? Colors.green[100] : Colors.white, // Change color when selected
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
            ),
    );
  }
}
