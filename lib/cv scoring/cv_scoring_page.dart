import 'package:flutter/material.dart';
import 'package:freedom_app/components/custom_app_bar.dart';
import 'package:freedom_app/cv%20scoring/mock_data.dart';

class ResumeScoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("Скоринг резюме", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
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
                  },
                  child: Text("Очистить все",
                      style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MockDataPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Применить"),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Profession Dropdown
            Text("Профессия"),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: "Software Engineer",
              items: [
                DropdownMenuItem(
                  child: Text("Software Engineer"),
                  value: "Software Engineer",
                ),
                DropdownMenuItem(
                  child: Text("Data Scientist"),
                  value: "Data Scientist",
                ),
                DropdownMenuItem(
                  child: Text("Product Manager"),
                  value: "Product Manager",
                ),
              ],
              onChanged: (value) {
                // Update profession selection
              },
            ),
            SizedBox(height: 20),

            // Experience Dropdown
            Text("Опыт работы"),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: "1-3 years",
              items: [
                DropdownMenuItem(
                  child: Text("1-3 years"),
                  value: "1-3 years",
                ),
                DropdownMenuItem(
                  child: Text("3-5 years"),
                  value: "3-5 years",
                ),
                DropdownMenuItem(
                  child: Text("5+ years"),
                  value: "5+ years",
                ),
              ],
              onChanged: (value) {
                // Update experience selection
              },
            ),
            SizedBox(height: 20),

            // Salary Rate Dropdown
            Text("Ожидаемая зарплата"),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: "\$40k-\$60k",
              items: [
                DropdownMenuItem(
                  child: Text("\$40k-\$60k"),
                  value: "\$40k-\$60k",
                ),
                DropdownMenuItem(
                  child: Text("\$60k-\$80k"),
                  value: "\$60k-\$80k",
                ),
                DropdownMenuItem(
                  child: Text("\$80k+"),
                  value: "\$80k+",
                ),
              ],
              onChanged: (value) {
                // Update salary rate selection
              },
            ),
          ],
        ),
      ),
    );
  }
}
