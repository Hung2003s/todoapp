import 'package:flutter/material.dart';
import 'package:todoapp_lmhung/list.dart';
import 'package:todoapp_lmhung/screen/add_edit_todo_screen.dart';
import 'package:todoapp_lmhung/widget/todo_filter.dart';
import 'package:todoapp_lmhung/widget/todo_item.dart';

import '../model/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSelectionMode = false;
  final Set<int> _selectedTodo = {};
  final List<String> _categories = [
    'Tất cả công việc',
    'Chưa thực hiện',
    'Đang thực hiện',
    'Đã hoàn thành',
    'Bị hủy',
  ];
  late int selectedindex = 0;
  void _showcancledialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Bạn chưa chọn động vật để xóa'),
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

  late String type = "Tất cả công việc";

  void _filterTodo(int index) {
    setState(() {
      selectedindex = index;
    });
    switch (selectedindex) {
      case 0:
        type = "Tất cả công việc";
        break;
      case 1:
        type = "Chưa thực hiện";
        break;
      case 2:
        type = "Đang thực hiện";
        break;
      case 3:
        type = "Đã hoàn thành";
        break;
      case 4:
        type = "Bị hủy";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildHeader(),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedindex = index;
                    });
                  },
                  child: TodoFilter(
                    status: _categories[index],
                    isSelected: selectedindex == index,
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Số lượng công việc còn lại: ${listTodo.length}"),
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listTodo.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTodo.contains(listTodo[index].id);
                  print('phan tu thu ${index} cua list: ${listTodo[index].id}');
                  return Row(
                    children: [
                      _isSelectionMode
                          ? Checkbox(
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedTodo.add(listTodo[index].id);
                                } else {
                                  _selectedTodo.remove(listTodo[index].id);
                                }
                              });
                            },
                          )
                          : Container(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push<Todo?>(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => AddEditTodoScreen(
                                      todo: listTodo[index],
                                    ),
                              ),
                            ).then((value) {
                              setState(() {});
                            });

                            // final todo = await Navigator.push<Todo?>(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder:
                            //         (_) => AddEditTodoScreen(
                            //           todo: listTodo[index],
                            //         ),
                            //   ),
                            // );
                            // setState(() {
                            //   listTodo[index]= todo!;
                            // });
                            //  print("todo.toString() = ${todo.toString()}");
                            //  print("listtodo = ${listTodo[index].toString()}");
                          },
                          child: TodoItem(todo: listTodo[index]),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await Navigator.push<Todo?>(
            context,
            MaterialPageRoute(builder: (_) => AddEditTodoScreen()),
          );
          setState(() {});
        },
        backgroundColor: Colors.orange,
        shape: const CircleBorder(),
        elevation: 2.0,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ), // Độ nổi),
    );
  }

  Widget _BuildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: Colors.white, // Màu nền Header
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.menu, color: Colors.grey[700]),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'XIN CHÀO',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Text(
                        'Lê Minh Hùng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(width: 20),
          PopupMenuButton(
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.white),
            ),
            itemBuilder:
                (_) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Đăng xuất'),
                      ],
                    ),
                  ),
                ],
          ),
          if (_isSelectionMode) ...[
            IconButton(
              onPressed: () {
                _selectedTodo.isEmpty
                    ? _showcancledialog()
                    : _showDeleteConfirmation(_selectedTodo.toList());

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
          ] else ...[
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
    );
  }
}
