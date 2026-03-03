import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_apps_fragment/view_apps_fragment.dart';
import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_schedule_apps_fragment/view_schedule_apps_fragment.dart';
import 'package:flutter/material.dart';

class MainBottomNavScreen extends StatelessWidget {
  MainBottomNavScreen({super.key});

  // List of pages to be displayed in the bottom navigation bar
  final List<Widget> _pages = const [
    ViewAppsFragment(),
    ViewScheduleAppsFragment(),
  ];

  // Value notifier to listen to the current index of the bottom navigation bar
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  // Function to handle the tap on the bottom navigation bar
  void _onBottomNavTap(int index) {
    _currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, child) {
        return Scaffold(
          body: _pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'View Apps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Schedule Apps',
              ),
            ],
            onTap: _onBottomNavTap,
          ),
        );
      },
    );
  }
}
