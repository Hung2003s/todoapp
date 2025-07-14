import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp_lmhung/app_bloc/bloc.dart';

import 'package:todoapp_lmhung/app_bloc/state.dart';
import 'package:todoapp_lmhung/main.dart';
import 'package:todoapp_lmhung/router/router.dart';
import 'package:todoapp_lmhung/widget/todo_item.dart';

import '../../app_bloc/event.dart';
import '../../list.dart';
import '../../model/todo.dart';
import '../../widget/todo_filter.dart';
import '../add_edit_todo_screen.dart';

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
  bool filterStatus = false;
  List<Todo> listsubtask = [];

  void _showcancledialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Bạn chưa chọn task để xóa'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(List<int>? Todoid) {
    var idToDelete = (Todoid ?? _selectedTodo.toList()).cast<int>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text(
            idToDelete.length == 1
                ? 'Bạn có chắc chắn muốn xóa task này'
                : 'Bạn có chắc chắn xóa, vui lòng kiểm tra lại',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _deleteTodo(idToDelete);
                });
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(List<int>? Todoid) {
    for (final id in Todoid!) {
      listTodo.removeWhere((item) => item.id == id);
    }
    print('so phan tu sau xóa: ${listTodo.length}');
    // Navigator.of(context).pop();

    // Hiển thị thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã xóa thành công'),
        backgroundColor: Colors.green,
      ),
    );
    List<dynamic> emptyList = [];
    Todoid = emptyList.cast<int>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<App_Bloc, AppState>(
      builder: (context, state) {
         final subtasks = state.todolist.where((t) => t.parent_id != null).toList();
        return Scaffold(
          body: (
              Container(
                margin: EdgeInsets.only(top: 20),
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
                        if (_isSelectionMode) ...[
                          IconButton(
                            onPressed: () {
                              _selectedTodo.isEmpty
                                  ? _showcancledialog()
                                  : _showDeleteConfirmation(
                                  _selectedTodo.toList());

                              //_showDeleteConfirmation;
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _isSelectionMode = false;
                                // _selectedAnimals.clear();
                              });
                            },
                          ),
                        ] else
                          ...[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isSelectionMode = true;
                                });
                              },
                              child: Text(
                                'Chọn',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                      ],
                    ),
                    // SizedBox(height: 15),
                    // Container(
                    //   height: 40,
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: 0, vertical: 5),
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: _categories.length,
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             selectedindex = index;
                    //           });
                    //         },
                    //         child: TodoFilter(
                    //           status: _categories[index],
                    //           isSelected: selectedindex == index,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    _BuildListTodo(context, selectedindex, state.appcolor,
                    state.todolist,
                    ),
                    SizedBox(height: 20,),
                    // SizedBox(height: 30,)
                  ],
                ),
              )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.push<Todo?>(
                context,
                MaterialPageRoute(builder: (_) => AddEditTodoScreen()),
              );
              setState(() {});
            },
            backgroundColor: state.appcolor,
            shape: const CircleBorder(),
            elevation: 2.0,
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        );
      },
    );
  }

  Widget _BuildListTodo(
      BuildContext context,
      int index, Color color,
      // bool? newStatus,
      List<Todo> list,
      ) {
    return list.isEmpty ? GestureDetector(
      onTap: () =>
          GoRouter.of(context).go(AppRouter.addTaskPath),
      child: Column(
        children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: color,
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
                          color: color,
                          borderRadius: BorderRadius.circular(
                              8),
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
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
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
    )
        : Expanded(
      flex: 1,
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: list.where((t) => t.parent_id == '').toList().length,
        itemBuilder: (context, index) {
          final List<Todo> maintask = list.where((t) => t.parent_id == '').toList();
          final isSelected = _selectedTodo.contains(maintask[index].id);
          print('list id: ${maintask[index].id}');

          return Row(
            children: [
              _isSelectionMode
                  ? Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedTodo.add(list[index].id);
                    } else {
                      _selectedTodo.remove(list[index].id);
                    }
                  });
                },
              ) : Container(),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push<Todo?>(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => AddEditTodoScreen(todo: list[index]),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: TodoItem(
                    todo: list.where((item) => item.parent_id =='').toList()[index],
                    color: color, 
                    listitem: list.where((item)=> item.parent_id != '').toList(),
                ),
              ),
              ),
            ],
          );
        },
      ),
    );
  }
}