import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoItem extends StatefulWidget {

  final Todo todo;
  final Color color;
  final Function onchange;

  const TodoItem({super.key, required this.todo, required this.color, required this.onchange});

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
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff0F163A).withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 36,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
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
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
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
                      Text(
                        widget.todo.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE0E5ED), width: 1),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mức độ ưu tiên: ${widget.todo.priority == Priority.high
                                ? 'Cao'
                                : widget.todo.priority == Priority.nomal
                                ? 'Trung bình'
                                : 'Thấp'}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff767E8C),
                            ),
                          ),
                          Text(
                            'Ngày tạo: ' + convertime(widget.todo.creatAt),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff767E8C),
                            ),
                          ),
                          Text(
                            'Deadline: ' + convertime(widget.todo.deadline),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff767E8C),
                            ),
                          ),

                        ],
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
                              child: Text(
                                'Chưa thực hiện',
                                style: TextStyle(
                                  color: Color(0xff6962c9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: Status.Ongoing,
                              child: Text(
                                'Đang thực hiện',
                                style: TextStyle(
                                  color: Color(0xfff6d236),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: Status.Finish,
                              child: Text(
                                'Đã hoàn thành',
                                style: TextStyle(
                                  color: Color(0xff50f636),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: Status.Canceled,
                              child: Text(
                                'Bị hủy',
                                style: TextStyle(
                                  color: Color(0xff36f6f6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (newValues) => widget.onchange ,
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
    );
  }
}
