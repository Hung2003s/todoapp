import 'package:flutter/material.dart';
import 'package:todoapp_lmhung/list.dart';
import 'package:todoapp_lmhung/model/todo.dart';

class AddEditTodoScreen extends StatefulWidget {
  final Todo? todo;
  final int? categoryindex;

  const AddEditTodoScreen({super.key, this.todo, this.categoryindex});

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final Todo todo;
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  //final TextEditingController _priorityController = TextEditingController();
  late DateTime selectedDate;
  Priority? _selectedPriority;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _contentController.text = widget.todo!.description;
      _dobController.text = widget.todo!.deadline.toString();
      _selectedPriority = widget.todo!.priority;
      selectedDate = widget.todo!.deadline;
    }
  }

  int idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch;
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void saveChange() {
    if (widget.todo != null) {
      for(int i = 0 ; i < listTodo.length; i ++) {
        if(listTodo[i].id == widget.todo?.id) {
          listTodo[i] = widget.todo!.copyWith(
            title: _titleController.text,
            description: _contentController.text,
            deadline: selectedDate,
            priority: _selectedPriority,
          );
        }
      }
    } else {
      Todo todo = Todo(
        id: idGenerator(),
        title: _titleController.text,
        description: _contentController.text,
        status: Status.Todo,
        deadline: selectedDate,
        creatAt: DateTime.now(),
        priority: _selectedPriority,
      );
      // setState(() {
      listTodo.add(todo);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm Task Mới'), actions: []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //nhập tiêu đề
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Tiêu đề',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tiêu đề';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              // Trường nhập nội dung
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Nội dung',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập nội dung';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Phần chọn ngày tháng
              TextFormField(
                controller: _dobController,
                onTap: () {
                  _selectTime(context);
                },
                readOnly: true,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Deadline',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'vui lòng chọn ngày kết thúc';
                  }
                  return null;
                },
              ),
              // chọn mức độ ưu tiên
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mức độ ưu tiên',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildPriorityDropdown(),
                ],
              ),
              SizedBox(height: 20),
              // Nút thêm
              ElevatedButton(
                onPressed: () {
                  saveChange();
                  // // print('List sau add : ${listTodo.length}');
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child:
                    widget.todo != null
                        ? Text('Lưu thay đổi')
                        : Text('Thêm task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<Priority>(
      value: _selectedPriority,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color(0xffb9b9b9),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      items: const [
        DropdownMenuItem(value: Priority.high, child: Text('Cao')),
        DropdownMenuItem(value: Priority.nomal, child: Text('Trung bình')),
        DropdownMenuItem(value: Priority.low, child: Text('Thấp')),
      ],
      onChanged: (Priority? newValue) {
        setState(() {
          _selectedPriority = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Vui lòng chọn mức độ ưu tiên';
        }
        return null;
      },
    );
  }
}
