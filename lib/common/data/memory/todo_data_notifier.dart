import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:flutter/material.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo) {
    value.add(todo);
    //데이터 변경을 알려줌
    notifyListeners();
  }


}