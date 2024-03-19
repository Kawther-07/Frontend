import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(
          icon: Icon(Icons.home, color: currentIndex == 0 ? Color(0xFF5915BD) : Color(0xFF505050)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, color: currentIndex == 1 ? Color(0xFF5915BD) : Color(0xFF505050)),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school, color: currentIndex == 2 ? Color(0xFF5915BD) : Color(0xFF505050)),
          label: 'Education',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, color: currentIndex == 3 ? Color(0xFF5915BD) : Color(0xFF505050)),
          label: 'More',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFF5915BD),
      unselectedItemColor: Color(0xFF505050),
      onTap: onTap,
    );
  }
}
