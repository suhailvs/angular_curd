import 'dart:collection';
import 'dart:convert';
// import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:android/models/task.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    this.fetchTaks();
  }

  List<Task> _tasks = [];

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView(_tasks);
  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((todo) => !todo.completed));
  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((todo) => todo.completed));

  void addTodo(Task task) async {
    final response = await http.post(
      "https://angularcurd.herokuapp.com/users/",
      headers: {"Content-Type": "application/json"},
      body: json.encode(task),
    );
    if (response.statusCode == 201) {
      task.id = json.decode(response.body)['id'];
      _tasks.add(task);
      notifyListeners();
    } 
  }

  void toggleTodo(Task task) async {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    final response = await http.patch(
      "https://angularcurd.herokuapp.com/users/${task.id}",
      headers: {"Content-Type": "application/json"},
      body: json.encode(task),
    );
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      _tasks[taskIndex].toggleCompleted(); //revert back
    }
  }

  void deleteTodo(Task task) async{
    final response = await http.delete(
      "https://angularcurd.herokuapp.com/users/${task.id}",
    );
    if (response.statusCode == 204) {
      _tasks.remove(task);
      notifyListeners();
    }
  }

  fetchTaks() async {
    final response = await http.get("https://angularcurd.herokuapp.com/users/");
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _tasks = data.map<Task>((json) => Task.fromJason(json)).toList();
      notifyListeners();
    }
  }
}
