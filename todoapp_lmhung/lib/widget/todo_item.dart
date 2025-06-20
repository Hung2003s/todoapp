import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    super.key,
    required this.todo
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late String formattedDateTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String convertime(DateTime time) {


    // Lấy giờ và phút
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');

    // Lấy ngày, tháng, năm
    String day = time.day.toString().padLeft(2, '0');
    String month = time.month.toString().padLeft(2, '0');
    String year = time.year.toString();

    // Kết hợp thành chuỗi
     // Ví dụ: 14:30 - 20/06/2025
  return formattedDateTime = "$hour:$minute, $day/$month/$year";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    widget.todo.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 150,
                  child: DropdownButtonFormField<Status>(
                    value: widget.todo.status,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xff463b3b),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 5.0,
                      ),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: const [
                      DropdownMenuItem(
                        value: Status.Todo,
                        child: Text('Chưa thực hiện',style: TextStyle(
                          color: Color(0xff6962c9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                      DropdownMenuItem(
                        value: Status.Ongoing,
                        child: Text('Đang thực hiện', style: TextStyle(
                            color: Color(0xfff6d236),
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                      DropdownMenuItem(
                        value: Status.Finish,
                        child: Text('Đã hoàn thành', style: TextStyle(
                            color: Color(0xff50f636),
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                      DropdownMenuItem(
                        value: Status.Canceled,
                        child: Text('Bị hủy', style: TextStyle(
                            color: Color(0xff36f6f6),
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                    ],
                    onChanged: (newValue) {},
                  ),
                ),
              ],
            ),

          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.todo.description, style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 14,
            ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Mức độ ưu tiên: ${
                widget.todo.priority == Priority.high ? 'Cao'
                    : widget.todo.priority == Priority.nomal ? 'Trung bình' : 'Thấp'
            }',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12
            ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Thời gian tạo: ' + convertime(widget.todo.creatAt),style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                ),),
                Text('Deadline: ' + convertime(widget.todo.deadline)
                  ,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                  ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
