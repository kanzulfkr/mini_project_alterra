import 'package:bahanku/view/detail/detail_screen.dart';
import 'package:bahanku/view/forum/create_post_screen.dart';
import 'package:bahanku/view/forum/reference/forum_page.dart';
import 'package:bahanku/view/home/home.screen.dart';
import 'package:bahanku/view/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final _screens = [
    const HomeScreen(),
    const DetailScreen(),
    const ForumPage(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Widget customNavBar() {
      return BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        onTap: (i) => setState(
          () => _selectedIndex = i,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.symmetric(
                vertical: _selectedIndex == 0 ? 7 : 5,
              ),
              child: Image.asset(
                'assets/icons/home.png',
                width: 25,
                color: _selectedIndex == 0 ? Colors.blueAccent : Colors.grey,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin:
                  EdgeInsets.symmetric(vertical: _selectedIndex == 1 ? 7 : 5),
              child: Image.asset(
                'assets/icons/eye.png',
                width: 25,
                color: _selectedIndex == 1 ? Colors.blueAccent : Colors.grey,
              ),
            ),
            label: 'Detail',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin:
                  EdgeInsets.symmetric(vertical: _selectedIndex == 2 ? 7 : 5),
              child: Image.asset(
                'assets/icons/chat.png',
                width: 25,
                color: _selectedIndex == 2 ? Colors.blueAccent : Colors.grey,
              ),
            ),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin:
                  EdgeInsets.symmetric(vertical: _selectedIndex == 3 ? 7 : 5),
              child: Image.asset(
                'assets/icons/setting.png',
                width: 25,
                color: _selectedIndex == 3 ? Colors.blueAccent : Colors.grey,
              ),
            ),
            label: 'Settings',
          ),
        ],
      );
    }

    if (_selectedIndex == 2) {
      return Scaffold(
        bottomNavigationBar: customNavBar(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => PostForm(
                      title: 'Add new post',
                    ),
                  ),
                )
                .then((value) => context);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: customNavBar(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      );
    }
  }
}
