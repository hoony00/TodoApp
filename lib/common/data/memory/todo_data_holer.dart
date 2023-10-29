import 'package:fast_app_base/common/data/memory/todo_data_notifier.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:flutter/material.dart';

import '../../../screen/main/write/d_write_todo.dart';

class TodoDataHolder extends InheritedWidget {
  final TodoDataNotifier notifier;

  const TodoDataHolder({
    super.key,
    required super.child,
    required this.notifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static TodoDataHolder _of(BuildContext context) {
    TodoDataHolder inherited =
        (context.dependOnInheritedWidgetOfExactType<TodoDataHolder>())!;
    return inherited;
  }

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        print("incomplete 눌림");
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        print("ongoint 눌림");
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result =
            await ConfirmDialog('완료한 할 일을 다시 진행중으로 변경하시겠습니까?').show();
        result?.runIfSuccess((data){
          todo.status = TodoStatus.incomplete;
        });
    }
    notifier.notify();
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      notifier.addTodo(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));
    }
  }
}

extension TodoDataHolderExtension on BuildContext {
  TodoDataHolder get holder => TodoDataHolder._of(this);
}
