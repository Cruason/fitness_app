import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class CustomBottomNavigation extends StatefulWidget {
  final ValueChanged<String> navChanged;
  final String route;

  const CustomBottomNavigation({super.key, required this.navChanged, required this.route});
  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  var navList = [Pages.homePage, Pages.planListPage, Pages.detailPlanPage, Pages.profilePage];
  int index = 0;

  @override
  Widget build(BuildContext context) {

    var goToIndex = goToRoute(widget.route);
    index = (goToIndex == -1)? index: goToIndex;
    return CurvedNavigationBar(
      index: index,
      backgroundColor: Colors.transparent,
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        onTap: (ind){
          widget.navChanged(navList[ind].route);
        },
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        buttonBackgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        items: navList.map((e) => ImageIcon(AssetImage(e.iconPath!), color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)).toList()

    );
  }
  
  int goToRoute(String route){
    for (var i=0; i<navList.length; i++) { 
      if(navList[i].route == route){
        return i;
      }
    }
    return -1;
  }
}
