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
  TodoCuit() : super(const TodoBlocState(BlocStatus.initial, <Todo>[]));

  void addTodo() async {
    final result = await WriteTodoDialog().show();

    if (result != null) {
      final copiedOldTodoList = List.of(state.todoList); //변경 가능한 리스트로 만들기

      copiedOldTodoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
        createTime: DateTime.now(),
        status: TodoStatus.incomplete,
      ));

      emitNewList(copiedOldTodoList); // 새로운 리스트로 변경
    }
  }

  void changeTodoStatus(Todo todo) async {
    final copiedOldTodoList = List.of(state.todoList); //변경 가능한 리스트로 만들기
    final todoIndex =
        copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result =
            await ConfirmDialog('완료한 할 일을 다시 진행중으로 변경하시겠습니까?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }
    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);

    emitNewList(copiedOldTodoList);
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      final oldCopiedList = List<Todo>.from(state.todoList);
      oldCopiedList[oldCopiedList.indexOf(todo)] = todo.copyWith(
        title: result.text,
        dueDate: result.dateTime,
        modifiyTime: DateTime.now(),
      ); // 기존 리스트에서 수정된 todo를 찾아서 변경
      emitNewList(oldCopiedList);
    }
  }

  void removeTodo(Todo todo) {
    final oldCopiedList = List<Todo>.from(state.todoList);
    oldCopiedList.removeWhere(
        (element) => element.id == todo.id); // 기존 리스트에서 수정된 todo를 찾아서 삭제
    emitNewList(oldCopiedList);
  }

  void emitNewList(List<Todo> oldCopiedList) {
    emit(state.copyWith(todoList: oldCopiedList));
  }
}
