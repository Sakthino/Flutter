import 'package:flutter/material.dart';
import 'package:wildfree_02/screens/settings_page.dart';
import 'package:wildfree_02/screens/weather_page.dart'; // Import WeatherPage

import 'login_page.dart';
import 'logs_page.dart'; // Import LogsPage
import 'tasks_page.dart'; // Import TasksPage

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false, // Hide debug banner
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0; // Track current index for bottom navigation

  final List<Widget> tabs = [
    _buildTab(Icons.home, 'Home'),
    _buildTab(Icons.cloud, 'Weather'),
    _buildTab(Icons.checklist, 'Tasks'),
    _buildTab(Icons.assignment, 'Logs'),
    _buildTab(Icons.account_circle, 'Profile'),
  ];

  final List<Widget> pages = [
    HomePageContent(
      subtitle1: 'A animal was being detected in the Repeller',
      subtitle2: 'A bird was being detected in the Repeller',
      subtitle1Image: 'assets/images/pages/home/animal.png',
      subtitle2Image: 'assets/images/pages/home/bird.png',
    ),
    WeatherPage(), // Replace with WeatherPage
    TasksPage(), // Replace with TasksPage
    LogsPage(), // Replace with LogsPage
    ProfilePage(), // Replace with ProfilePage
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static Widget _buildTab(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Tab(
        icon: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'WILDFREE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color set to white
            ),
          ),
          centerTitle: true, // Center align the title
          backgroundColor:
              Colors.lightGreen[400], // Updated app bar color to light green
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: Text('Feedback'),
                  value: 'feedback',
                ),
                PopupMenuItem(
                  child: Text('Help'),
                  value: 'help',
                ),
              ],
              onSelected: (value) {
                // Handle menu item selection
                if (value == 'feedback') {
                  // Navigate to feedback page
                } else if (value == 'help') {
                  // Navigate to help page
                }
              },
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex, // Set current index
          items: [
            _buildBottomNavItem(Icons.home, 'Home', 0),
            _buildBottomNavItem(Icons.cloud, 'Weather', 1),
            _buildBottomNavItem(Icons.checklist, 'Tasks', 2),
            _buildBottomNavItem(Icons.assignment, 'Logs', 3),
            _buildBottomNavItem(Icons.account_circle, 'Profile', 4),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Update current index
            });
            _tabController.animateTo(index); // Navigate to tab
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _currentIndex == index
            ? 36
            : 24, // Adjust width based on current index
        height: _currentIndex == index
            ? 36
            : 24, // Adjust height based on current index
        child: Icon(icon),
      ),
      label: label,
    );
  }
}

class HomePageContent extends StatelessWidget {
  final String subtitle1;
  final String subtitle2;
  final String subtitle1Image;
  final String subtitle2Image;

  HomePageContent({
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle1Image,
    required this.subtitle2Image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSubtitleItem(
            title: 'Animal Detection',
            text: subtitle1,
            image: subtitle1Image,
            color: Colors.green, // Change color to green
          ),
          _buildSubtitleItem(
            title: 'Bird Detection',
            text: subtitle2,
            image: subtitle2Image,
            color: Colors.green, // Change color to green
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "WildFree introduces an advanced wildlife repellent system integrating AIML and IoT technologies. WildFree integrates cutting-edge technology to provide effective wildlife repellent solutions, ensuring proactive protection against animal and bird intrusions. WildFree's innovative approach reduces crop damage, prevents human-wildlife conflicts, and promotes sustainable agricultural practices. With customizable configurations and easy integration, our wildlife repellent system offers a reliable and eco-friendly solution for farms, orchards, and natural habitats seeking efficient wildlife management",
              textAlign: TextAlign.justify, // Align the paragraph
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Text color set to black
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleItem(
      {required String title,
      required String text,
      required String image,
      required Color color}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: color, // Use the provided color
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Image.asset(image),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
