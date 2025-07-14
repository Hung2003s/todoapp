import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_lmhung/app_bloc/bloc.dart';
import 'package:todoapp_lmhung/app_bloc/state.dart';
import 'package:todoapp_lmhung/screen/calendar_page/calendar_screen.dart';
import 'package:todoapp_lmhung/screen/home_page/home_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedindex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    TableEventsExample(),
    Container(),
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<App_Bloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: _screen.elementAt(_selectedindex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedindex,
            selectedItemColor: state.appcolor,
            unselectedItemColor: Colors.grey,
            onTap: _selectScreen,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_open),
                label: 'Nhiệm vụ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded),
                label: 'Lịch',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Của tôi',
              ),
            ],
          ),
        );
      },
    );
  }
}
