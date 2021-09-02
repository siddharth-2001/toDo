import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> form = {'title': ''};

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    Provider.of<TaskList>(context, listen: false)
        .addTask(form['title']!)
        .catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                cursorColor: theme.primaryColor,
                decoration: InputDecoration(

                    hintText: 'Title',
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: theme.primaryColor))),
                onSaved: (val) {
                  print(val);
                  form['title'] = val!;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    _saveForm();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Task'))
            ],
          ),
        ),
      ),
    );
  }
}