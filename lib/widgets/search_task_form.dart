import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/task.dart';

class SearchTask extends StatefulWidget {
  @override
  _SearchTaskState createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> form = {
    'search': '',
  };

  void saveForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    Provider.of<TaskList>(context, listen: false).searchTask(form['search']!);
    Navigator.of(context).pushReplacementNamed('/search');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                cursorColor: theme.primaryColor,
                decoration: InputDecoration(
                    hintText: 'Enter title to search',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor))),
                onSaved: (value) {
                  form['search'] = value!;
                },
              ),
             const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    saveForm();
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Search'))
            ],
          ),
        ),
      ),
    );
  }
}
