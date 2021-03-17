import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Task {
  int id;
  String firstName;
  String lastName;
  bool completed;

  Task({this.id, @required this.firstName, @required this.lastName, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }

  factory Task.fromJason(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      completed: false,
    );
  }
  dynamic toJson() => { 'firstName': firstName,'lastName':lastName, 'completed': completed };
}