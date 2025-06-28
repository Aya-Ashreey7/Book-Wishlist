import 'package:book_wishlist/main.dart' show MyHomePage;
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MyHomePage(), // Actual home page from main.dart
    const Center(child: Text('Favorite')),
    const Center(child: Text('Account')),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[200],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          _buildNavItem(icon: Icons.home, label: 'Home', index: 0),
          _buildNavItem(icon: Icons.favorite, label: 'Favorite', index: 1),
          _buildNavItem(icon: Icons.person, label: 'Account', index: 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      label: label,
      icon: Column(
        children: [
          Container(
            decoration: isSelected
                ? BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
