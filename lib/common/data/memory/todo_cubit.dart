import 'package:fast_app_base/common/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/common/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/common/data/memory/todo_status.dart';
import 'package:fast_app_base/common/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../screen/main/write/d_write_todo.dart';
// InheritedWidget를 이용한 상태관리 끝 - 1031(화) 오전 12시
class TodoCuit extends Cubit<TodoBlocState> {
  final RxList<Todo> todoList = <Todo>[].obs;

  TodoCuit() : super(const TodoBlocState(BlocStatus.initial, <Todo>[]));



  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result =
            await ConfirmDialog('완료한 할 일을 다시 진행중으로 변경하시겠습니까?').show();
        result?.runIfSuccess((data){
          todo.status = TodoStatus.incomplete;
        });
    }
    todoList.refresh();
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      todoList.refresh();
    }
  }

  void removeTodo(Todo todo) {
    todoList.remove(todo);
    todoList.refresh();
  }
}

