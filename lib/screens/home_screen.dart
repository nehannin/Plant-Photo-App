import 'package:flutter/material.dart';
import 'list_view.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';


/// The main home screen of the app with bottom navigation.
/// It allows users to switch between the List, Settings, and Profile screens.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Tracks the currently selected index in the bottom navigation bar.
  int _currentIndex = 0;

  /// A list containing the different screens that can be navigated to.
  final List<Widget> _screens = [
    ListViewScreen(), // Screen displaying the list of plants
    SettingsScreen(), // Screen for app settings
    ProfileScreen(), // Screen for user profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// Displays the currently selected screen.
      body: _screens[_currentIndex],

      /// Bottom navigation bar for switching between screens.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Updates the selected screen index
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List', // Represents the plant list screen
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings', // Represents the settings screen
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Represents the profile screen
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
