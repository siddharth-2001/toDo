import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/task_screen.dart'; //local imports
import './providers/task.dart';
import './screens/search_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark
    )
  );
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskList>(create: (context) => TaskList()),
      ],
      child: MaterialApp(
        title: 'ToDo',
        theme: ThemeData(
            primaryColor:const Color.fromRGBO(108, 128, 251, 1),
            accentColor:const Color.fromRGBO(114, 255, 220, 1),
            checkboxTheme: CheckboxThemeData(
              checkColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(108, 128, 251, 1)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(108, 128, 251, 1)))),
            textTheme: TextTheme(
                bodyText1: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                bodyText2: TextStyle())),
        home: TaskScreen(),
        routes: {
          TaskScreen.routeName: (context) => TaskScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
        },
      ),
    );
  }
}
