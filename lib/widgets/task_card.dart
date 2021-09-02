import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart'; //local task

class TaskCard extends StatefulWidget {
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _checkBox = false;

  @override
  void initState() {
    _checkBox = Provider.of<TaskItem>(context, listen: false).status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskItem>(context);
    final taskList = Provider.of<TaskList>(context, listen: false);
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.horizontal,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(color: Color.fromRGBO(255, 82, 82, 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Deleting',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'Deleting',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      onDismissed: (direction) async {
        taskList.removeTask(task.title, task.id).catchError((error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      },
      child: Card(
        child: ListTile(
          leading: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.cyan,
            ),
            child: Checkbox(
              activeColor: Colors.white,
              value: _checkBox,
              onChanged: (val) async {
                setState(() {
                  _checkBox = val!;
                  Provider.of<TaskItem>(context, listen: false)
                      .changeStatus(val)
                      .catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  });
                });
              },
            ),
          ),
          title: Text(
            '${task.title}',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                decoration: _checkBox
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
