import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/task.dart';
import '../widgets/task_card.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/add_task_form.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);
  static const routeName = '/tasks';

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _isLoading = false;

  void _showAddTaskSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TaskForm();
        });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<TaskList>(context, listen: false)
        .fetchAndSetTasks()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final taskData = Provider.of<TaskList>(context);
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            )
          : ListView.builder(
              itemCount: taskData.taskList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider<TaskItem>.value(
                  value: taskData.taskList[index],
                  child: TaskCard(),
                );
              }),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskSheet(context);
        },
        child: Icon(
          Icons.add,
          color: theme.primaryColor,
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
