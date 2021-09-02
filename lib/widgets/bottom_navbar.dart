import 'package:flutter/material.dart';

import '../widgets/search_task_form.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  void _showSearchTaskSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SearchTask();
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/tasks');
              },
              icon: Icon(
                Icons.menu,
                color: theme.primaryColor,
              ),
              label: Text(
                'Tasks',
                style: theme.textTheme.bodyText1,
              )),
          IconButton(
              onPressed: () {
                _showSearchTaskSheet(context);
              },
              icon: Icon(
                Icons.search,
                color: theme.primaryColor,
              ))
        ],
      ),
    );
  }
}
