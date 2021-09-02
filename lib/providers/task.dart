import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class TaskItem with ChangeNotifier {
  final String title;
  final String id;
  bool isDone;

  TaskItem({required this.id, required this.title, required this.isDone});

  Future<void> changeStatus(bool value) async {
    final url = Uri.parse(
        'https://todo-c1a86-default-rtdb.asia-southeast1.firebasedatabase.app/tasks/$id.json');
    final response = await http.patch(url,
        body: jsonEncode({
          'isDone': value,
        }));
    if (response.statusCode >= 400) {
      throw HttpException('Some error occured');
    }
    isDone = value;
    notifyListeners();
  }

  bool get status {
    return isDone;
  }
}

class TaskList with ChangeNotifier {
  List<TaskItem> _tasks = [];

  Future<void> fetchAndSetTasks() async {
    List<TaskItem> loadedTasks = [];
    final url = Uri.parse(
        'https://todo-c1a86-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json');

    try {
      await http.get(
          url); //since firebase does not return anything if there is no task, I had to do manage it here
    } catch (error) {
      return;
    }
    final response = await http.get(url);

    if (jsonDecode(response.body) == Null) {
      notifyListeners();
      return;
    }
    if (response.statusCode >= 400) {
      throw HttpException('Could Not Delete');
    }
    final taskData = jsonDecode(response.body) as Map<String, dynamic>;
    taskData.forEach((key, value) {
      loadedTasks.add(
          TaskItem(id: key, title: value['title'], isDone: value['isDone']));
    });
    _tasks = loadedTasks;
    notifyListeners();
  }

  List<TaskItem> _searchList = [];

  List get searchList {
    return [..._searchList];
  }

  List get taskList {
    return [..._tasks];
  }

  Future<void> removeTask(String title, String id) async {
    final url = Uri.parse(
        'https://todo-c1a86-default-rtdb.asia-southeast1.firebasedatabase.app/tasks/$id.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw HttpException('Could Not Delete');
    }
    print('here');
    _tasks.removeWhere((element) => element.title == title);
    _searchList.removeWhere((element) => element.title == title);
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    final url = Uri.parse(
        'https://todo-c1a86-default-rtdb.asia-southeast1.firebasedatabase.app/tasks.json');
    final response = await http.post(url,
        body: jsonEncode({'title': title, 'isDone': false}));
    if (response.statusCode >= 400) {
      throw HttpException('Could Not Delete');
    }
    final id = jsonDecode(response.body)['name'];
    _tasks.add(TaskItem(id: id, title: title, isDone: false));
    notifyListeners();
  }

  void searchTask(String search) {
    _searchList = _tasks.where((element) => element.title == search).toList();
  }
}
