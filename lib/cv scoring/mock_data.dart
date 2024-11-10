import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freedom_app/components/custom_app_bar.dart';

class MockDataPage extends StatefulWidget {
  @override
  _MockDataPageState createState() => _MockDataPageState();
}

class _MockDataPageState extends State<MockDataPage> {
  List<dynamic> people = [];
  bool isLoading = false;

  // Mock API request to fetch data from enbek.json
  Future<void> fetchPeople() async {
    setState(() {
      isLoading = true;
    });

    // Simulate a network delay with Future.delayed
    await Future.delayed(Duration(seconds: 2));

    // Mock data (This simulates fetching from enbek.json)
    List<dynamic> mockData = [
      {"id": 1, "name": "John Doe", "profession": "Software Engineer", "experience": "3-5 years", "salary": "\$60k-\$80k", "city": "Almaty"},
      {"id": 2, "name": "Jane Smith", "profession": "Product Manager", "experience": "1-3 years", "salary": "\$40k-\$60k", "city": "Astana"},
      {"id": 3, "name": "Alex Johnson", "profession": "Data Scientist", "experience": "5+ years", "salary": "\$80k+", "city": "Shymkent"},
      {"id": 4, "name": "Alice Brown", "profession": "Software Engineer", "experience": "3-5 years", "salary": "\$60k-\$80k", "city": "Almaty"},
      {"id": 5, "name": "Bob White", "profession": "Product Manager", "experience": "1-3 years", "salary": "\$40k-\$60k", "city": "Astana"},
      {"id": 6, "name": "Charlie Davis", "profession": "Data Scientist", "experience": "5+ years", "salary": "\$80k+", "city": "Shymkent"},
      {"id": 7, "name": "Eva Moore", "profession": "Software Engineer", "experience": "1-3 years", "salary": "\$40k-\$60k", "city": "Almaty"},
      {"id": 8, "name": "Liam Wilson", "profession": "Product Manager", "experience": "3-5 years", "salary": "\$60k-\$80k", "city": "Astana"},
      {"id": 9, "name": "Mia Taylor", "profession": "Data Scientist", "experience": "5+ years", "salary": "\$80k+", "city": "Shymkent"},
      {"id": 10, "name": "Noah Harris", "profession": "Software Engineer", "experience": "3-5 years", "salary": "\$60k-\$80k", "city": "Almaty"},
    ];

    // Simulate random selection of 10 people
    people = List.generate(10, (_) => mockData[Random().nextInt(mockData.length)]);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: const Text("Результаты скоринга", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  var person = people[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(person["name"]),
                      subtitle: Text("${person["profession"]} - ${person["experience"]}"),
                      trailing: Text(person["salary"]),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
