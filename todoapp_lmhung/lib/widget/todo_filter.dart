import 'package:flutter/material.dart';

class TodoFilter extends StatefulWidget {
  final String status;
  final bool isSelected;
  const TodoFilter({super.key, required this.status, required this.isSelected, });

  @override
  State<TodoFilter> createState() => _TodoFilterState();
}

class _TodoFilterState extends State<TodoFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: widget.isSelected ? Color(0xfff55c00) : Color(0xff96f579),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(widget.status,style: TextStyle(
        color: widget.isSelected ? Color(0xffffffff) : Color(0xff111111)
      ),),
    );
  }
}
