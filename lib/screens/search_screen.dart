import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/task.dart';
import '../widgets/task_card.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/add_task_form.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  void _showAddTaskSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TaskForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final taskData = Provider.of<TaskList>(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: taskData.searchList.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider<TaskItem>.value(
              value: taskData.searchList[index],
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