
import 'package:emf_tontine/colors/colors.dart';
import 'package:emf_tontine/screens/dashboard.dart';
import 'package:emf_tontine/screens/nav_bar_menu.dart';
import 'package:emf_tontine/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'clients.dart';
class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}


class _BottomState extends State<Bottom> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int selectedIndex = 0;
  void _onItemTapped(int index){
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });

  }
  static final List<Widget> _widget0ptions =<Widget>[
    const Dashboard(),
    const Clients(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Dashboard(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Clients(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProfileScreen(),
              );
            });
          default: return CupertinoTabView(builder: (context) {
            return CupertinoPageScaffold(
              child: Dashboard(),
            );
          });
        }
      },
    );
  //   return Scaffold(
  //     key: _scaffoldKey,
  //     drawer: MyDrawer(title: "Home",),
  //     backgroundColor: kLightGrey,
  //     body:_widget0ptions[selectedIndex],
  //
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home, size: 30,),
  //           label: 'Home',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.search, size: 30,),
  //           label: 'Recherche',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person, size: 30,),
  //           label: 'Profile',
  //         ),
  //       ],
  //       currentIndex: selectedIndex,
  //       selectedItemColor: Colors.indigoAccent,
  //       onTap: _onItemTapped,
  //       showUnselectedLabels: false,
  //       showSelectedLabels: false,
  //     ),
  //     //  bottomNavigationBar: BottomNavigationBar(
  //     //   onTap: _onItemTapped,
  //     //   elevation: 10,
  //     //   showSelectedLabels: false,
  //     //   showUnselectedLabels: false,
  //     //   // selectedItemColor: Colors.amber[800],
  //     //   unselectedItemColor: const Color(0xFF526480),
  //     //   items: const <BottomNavigationBarItem> [
  //     //     BottomNavigationBarItem(icon: Icon(Icons.home, size: 30, ),label: 'Home',),
  //     //     BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: 'Recherche',),
  //     //     BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: 'Profile',),
  //     //     // BottomNavigationBarItem(icon: Icon(Icons.settings, size: 35,), label: 'Paramètres'),
  //     //   ],
  //     // ),
  //   );
   }
}
