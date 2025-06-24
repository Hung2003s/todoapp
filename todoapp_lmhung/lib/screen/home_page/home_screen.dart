import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp_lmhung/app_bloc/bloc.dart';
import 'package:todoapp_lmhung/app_bloc/event.dart';
import 'package:todoapp_lmhung/app_bloc/state.dart';
import 'package:todoapp_lmhung/router/router.dart';
import 'package:todoapp_lmhung/widget/todo_item.dart';

import '../../list.dart';
import '../../model/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //screen cũ
  bool _isSelectionMode = false;
  final Set<int> _selectedTodo = {};
  final List<String> _categories = [
    'Tất cả công việc',
    'Chưa thực hiện',
    'Đang thực hiện',
    'Đã hoàn thành',
    'Bị hủy',
  ];
  int selectedindex = 0;
  Status filterStatus = Status.Todo;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<App_Bloc, AppState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          color: Color(0xff1B1C1F),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Best platform for creating to-do list',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff767E8C),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings, color: Color(0xff767E8C)),
                  ),
                ],
              ),
              SizedBox(height: 15),

              listTodo.isEmpty ? GestureDetector(
                onTap: () => GoRouter.of(context).go(AppRouter.addTaskPath),
                child: Column(
                  children: [
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: state.appcolor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: state.appcolor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Tap plus to create a new task ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 1,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffE0E5ED),
                                width: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add your task',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff767E8C),
                                  ),
                                ),
                                Text(
                                  'Today. Mon 20 Jul 2022',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff767E8C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ) : Expanded(
                flex: 1,
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: listTodo.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      todo: listTodo[index],
                      color: state.appcolor,
                      onchange: (newValue){
                            listTodo[index].copyWith(
                              title: listTodo[index].title,
                              description: listTodo[index].description,
                              deadline: listTodo[index].deadline,
                              status: newValue,
                            );

                      },);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
