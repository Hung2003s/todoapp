import 'package:flutter/material.dart';
import 'package:todoapp_lmhung/screen/home_page/home_screen.dart';
import 'package:todoapp_lmhung/screen/home_page/homepage_choosetheme.dart';
import 'package:todoapp_lmhung/screen/home_page/home_screen2.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  int _selectedindex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screen.elementAt(_selectedindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.black,),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox, color: Colors.black,),
              label: 'Message'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded, color: Colors.black,),
              label: 'Calendar'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.apps_outlined, color: Colors.black,),
              label: 'Filter'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black,),
              label: 'Setting'
          ),
        ],),
    );
  }
}
