import 'package:flutter/material.dart';
import 'package:freedom_app/components/custom_app_bar.dart';
import 'package:freedom_app/cv%20scoring/mock_data.dart';

class ResumeScoringPage extends StatefulWidget {
  const ResumeScoringPage({super.key});

  @override
  _ResumeScoringPageState createState() => _ResumeScoringPageState();
}

class _ResumeScoringPageState extends State<ResumeScoringPage> {
  // Selected values
  String? _selectedProfession;
  List<String> _selectedTools = [];
  String? _selectedLevel;

  // Data for the stacks (tools)
  final List<String> tools = ['Figma', 'Adobe XD', 'Sketch', 'InVision', 'Photoshop'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: Text("Скоринг резюме", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Clear all filters logic
                      setState(() {
                        _selectedProfession = null;
                        _selectedTools.clear();
                        _selectedLevel = null;
                      });
                    },
                    child: const Text("Очистить все", style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MockDataPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Background color
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Применить"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
        
              // Profession Dropdown (Including "Designer")
              const Text("Профессия"),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: _selectedProfession,
                items: const [
                  DropdownMenuItem(value: "Software Engineer", child: Text("Software Engineer")),
                  DropdownMenuItem(value: "Data Scientist", child: Text("Data Scientist")),
                  DropdownMenuItem(value: "Product Manager", child: Text("Product Manager")),
                  DropdownMenuItem(value: "Designer", child: Text("Designer")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedProfession = value;
                  });
                },
              ),
              const SizedBox(height: 20),
        
              // Stack of Design Tools (for Designers)
              if (_selectedProfession == "Designer") ...[
                const Text("Выберите инструменты (Stack)"),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tools.map((tool) {
                    return ChoiceChip(
                      label: Text(tool),
                      selected: _selectedTools.contains(tool),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedTools.add(tool);
                          } else {
                            _selectedTools.remove(tool);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),
        
              // Level Dropdown (Junior, Middle, Senior)
              const Text("Уровень"),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: _selectedLevel,
                items: const [
                  DropdownMenuItem(value: "Junior", child: Text("Junior")),
                  DropdownMenuItem(value: "Middle", child: Text("Middle")),
                  DropdownMenuItem(value: "Senior", child: Text("Senior")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLevel = value;
                  });
                },
              ),
              const SizedBox(height: 20),
        
              // Experience Dropdown
              const Text("Опыт работы"),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: "1-3 years",
                items: const [
                  DropdownMenuItem(value: "1-3 years", child: Text("1-3 years")),
                  DropdownMenuItem(value: "3-5 years", child: Text("3-5 years")),
                  DropdownMenuItem(value: "5+ years", child: Text("5+ years")),
                ],
                onChanged: (value) {
                  // Update experience selection
                },
              ),
              const SizedBox(height: 20),
        
              // Salary Rate Dropdown
              const Text("Ожидаемая зарплата"),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: "\$40k-\$60k",
                items: const [
                  DropdownMenuItem(value: "\$40k-\$60k", child: Text("\$40k-\$60k")),
                  DropdownMenuItem(value: "\$60k-\$80k", child: Text("\$60k-\$80k")),
                  DropdownMenuItem(value: "\$80k+", child: Text("\$80k+")),
                ],
                onChanged: (value) {
                  // Update salary rate selection
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
