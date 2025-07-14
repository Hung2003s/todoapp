import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_lmhung/app_bloc/bloc.dart';
import 'package:todoapp_lmhung/app_bloc/event.dart';

import '../app_bloc/state.dart';
import '../model/todo.dart';

class TodoItem extends StatefulWidget {
  final List<Todo> listitem;
  final Todo todo;
  final Color color;
  const TodoItem({
    super.key,
    required this.todo,
    required this.color,
    required this.listitem,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late String formattedDateTime;

  bool? isChecked = false;

  late bool isdone = false;

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
    return BlocBuilder<App_Bloc, AppState>(
      builder: (context, state) {
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
                  color: widget.color.withValues(alpha: widget.todo.status == true ? 0.6 : 1),
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
                        widget.todo.maintask,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          decoration:
                          widget.todo.status == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
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
                          // widget.todo.parent_id != '' ?
                          // Container() :
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.listitem.length,
                              itemBuilder: (BuildContext context, int index) {
                                return widget.listitem[index].parent_id ==
                                        widget.todo.id.toString()
                                    ? Row(
                                      children: [
                                        Container(
                                          child: Checkbox(
                                            shape: CircleBorder(),
                                            value: widget.todo.status == true ? widget.todo.status  :widget.listitem[index].status,
                                            onChanged: (_) {
                                                context.read<App_Bloc>().add(
                                                  ToggleTask(widget.listitem[index].id),
                                                  // widget.listitem[index].status =
                                                  //     newvalue;
                                                );
                                               print('${widget.listitem[index].status} : ${widget.listitem[index].id}');
                                            },
                                          ),
                                        ),
                                        Text(
                                          widget.listitem[index].maintask,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff333333),
                                            decoration:

                                            widget.listitem[index].status == true || widget.todo.status == true
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                          ),
                                        ),
                                      ],
                                    )
                                    : Container();
                              },
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
                                  decoration:
                                  widget.todo.status == true
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                ),
                              ),
                              Text(
                                'Deadline: ' + convertime(widget.todo.deadline),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff767E8C),
                                  decoration:
                                      widget.todo.status == true
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Checkbox(
                              shape: CircleBorder(),
                              value: widget.todo.status,
                              onChanged: (_) {
                                context.read<App_Bloc>().add(
                                  ToggleTask(widget.todo.id),
                                  // widget.listitem[index].status =
                                  //     newvalue;
                                  //
                                );
                                for(int i = 0 ; i < widget.listitem.length; i++) {
                                  if (widget.listitem[i].id == widget.todo.id) {
                                    context.read<App_Bloc>().add(
                                        SetTaskTrue(widget.listitem[i].id));
                                  }
                                }

                              },
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
      },
    );
  }
}
