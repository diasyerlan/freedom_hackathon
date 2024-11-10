// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:freedom_app/cv%20grid/cv_grid_page.dart';
import 'package:freedom_app/cv%20scoring/cv_scoring_page.dart';
import 'package:freedom_app/gemini/gemini_page.dart';
import 'package:freedom_app/main%20page/main_page.dart';
import 'package:freedom_app/models/job.dart';
import 'package:freedom_app/profile%20page/profile.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const NavigatorPage(child: MainPage()),
      NavigatorPage(child: ResumeGridPage()),
      NavigatorPage(child: GeminiPage()),
      NavigatorPage(child: ResumeScoringPage()),
      NavigatorPage(child: ProfileScreen()),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/1.png"),
              size: 33,
              color: _currentIndex == 0 ? Colors.green : Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/2.png"),
              size: 33,
              color: _currentIndex == 1 ? Colors.green : Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/3.png"),
              size: 80,
              color: _currentIndex == 2 ? Colors.green : Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/4.png"),
              size: 33,
              color: _currentIndex == 3 ? Colors.green : Colors.black,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/5.png"),
              size: 33,
              color: _currentIndex == 4 ? Colors.green : Colors.black,
            ),
            label: "",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green, // Set selected color to green
        unselectedItemColor: Colors.black, // Set unselected color to black
      ),
    );
  }
}


class NavigatorPage extends StatelessWidget {
  final Widget child;

  const NavigatorPage({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (_) => child);
    });
  }
}
