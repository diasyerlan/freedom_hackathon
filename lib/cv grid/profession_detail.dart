import 'package:flutter/material.dart';
import 'package:freedom_app/models/job.dart';
import 'package:freedom_app/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessionDetailPage extends StatefulWidget {
  final String profession;
  final List<Job> jobs;

  const ProfessionDetailPage({required this.profession, required this.jobs});

  @override
  _ProfessionDetailPageState createState() => _ProfessionDetailPageState();
}

class _ProfessionDetailPageState extends State<ProfessionDetailPage> {
  int? selectedIndex; // Track the selected index

  void _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профессия ${widget.profession}')),
      body: ListView.builder(
        itemCount: widget.jobs.length,
        itemBuilder: (context, index) {
          final job = widget.jobs[index];
          final isSelected = index == selectedIndex;

          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index; // Update selectedIndex on tap
              });
              _openUrl(job.urls);
            },
            child: Card(
              color: isSelected ? Colors.green[300] : Colors.green[100], // Highlight color if selected
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(job.profession),
                subtitle: Text('${job.city} - ${job.salary}'),
                trailing: Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isFavorite(job);

                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          favoritesProvider.removeFavorite(job);
                        } else {
                          favoritesProvider.addFavorite(job);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
