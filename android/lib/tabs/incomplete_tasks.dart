import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android/providers/task_provider.dart';
import 'package:android/widgets/task_list.dart';

class IncompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TaskProvider>(
        builder: (context, todos, child) => TaskList(
          tasks: todos.incompleteTasks,
        ),
      ),
    );
  }
}
