import 'package:flutter/cupertino.dart';

CupertinoTabScaffold(
  tabBar: CupertinoTabBar(
    items: [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.music_note),
        label: 'Library',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: 'Profile',
      ),
    ],
  ),
  tabBuilder: (context, index) {
    return CupertinoTabView(
      builder: (context) {
        switch (index) {
          case 0:
            return LibraryScreen();
          case 1:
            return SearchScreen();
          case 2:
            return ProfileScreen();
          default:
            return LibraryScreen();
        }
      },
    );
  },
);
