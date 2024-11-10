import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freedom_app/components/custom_app_bar.dart';
import 'package:freedom_app/cv%20grid/profession_detail.dart';
import 'package:freedom_app/models/job.dart';

class ResumeGridPage extends StatefulWidget {
  const ResumeGridPage({super.key});

  @override
  State<ResumeGridPage> createState() => _ResumeGridPageState();
}

class _ResumeGridPageState extends State<ResumeGridPage> {
  // Map to hold jobs grouped by profession
  Map<String, List<Job>> _jobsByProfession = {};

  // Load jobs from JSON file
  Future<void> loadJobs() async {
    String jsonString = await rootBundle.loadString('assets/enbek.json');
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    List<Job> allJobs = jsonResponse.map((jobJson) => Job.fromJson(jobJson)).toList();

    // Group jobs by profession
    setState(() {
      _jobsByProfession = {};
      for (var job in allJobs) {
        if (_jobsByProfession.containsKey(job.profession)) {
          _jobsByProfession[job.profession]!.add(job);
        } else {
          _jobsByProfession[job.profession] = [job];
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadJobs(); // Load jobs when the page is first loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: const Text('Сетка', style: TextStyle(color: Colors.white),)),
      body: _jobsByProfession.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Horizontal space between items
                mainAxisSpacing: 8.0, // Vertical space between items
                childAspectRatio: 2 / 3, // Aspect ratio of each grid item
              ),
              itemCount: _jobsByProfession.keys.length, // Number of unique professions
              itemBuilder: (context, index) {
                // Get the profession from the map keys
                final profession = _jobsByProfession.keys.elementAt(index);
                final peopleCount = _jobsByProfession[profession]!.length; // Get the number of people with this profession

                return GestureDetector(
                  onTap: () {
                    // Get all jobs for the selected profession
                    final filteredJobs = _jobsByProfession[profession]!;

                    // Navigate to the ProfessionDetailPage with the list of jobs for this profession
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfessionDetailPage(
                          profession: profession,
                          jobs: filteredJobs,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.green[100],
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(profession, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          const SizedBox(height: 8),
                          // Show the number of people with this profession
                          Text('$peopleCount человек'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
