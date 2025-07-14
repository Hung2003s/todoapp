// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp_lmhung/list.dart';

import 'model/todo.dart';

/// Example event class.

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
LinkedHashMap<DateTime, List<Todo>> generateEventMap(List<Todo> todos) {
  final Map<DateTime, List<Todo>> map = {};

  for (var todo in todos) {
    // Đưa deadline về 00:00 để so sánh theo ngày
    final date = DateTime(todo.deadline.year, todo.deadline.month, todo.deadline.day);

    if (map[date] == null ) {
      map[date] = [todo];
    } else if (todo.parent_id == '') {
      map[date]!.add(todo);
    }
  }

  return LinkedHashMap<DateTime, List<Todo>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(map);
}


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
