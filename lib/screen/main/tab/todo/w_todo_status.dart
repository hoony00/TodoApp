import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

import '../../../../common/data/memory/vo_todo.dart';

class TodoStatusWidget extends StatelessWidget {
  final Todo todo;
  const TodoStatusWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Checkbox(
        value: true,
        onChanged: null,
        fillColor: MaterialStateProperty.all( context.appColors.checkBoxColor),
      ),
    );
  }
}
