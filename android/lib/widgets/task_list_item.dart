import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android/models/task.dart';
import 'package:android/providers/task_provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({@required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (bool checked) {
          Provider.of<TaskProvider>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.firstName),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}
