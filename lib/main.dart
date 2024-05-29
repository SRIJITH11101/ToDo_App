import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/todo_page.dart';
import 'package:todo_app/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
            create: (context) => ActiveTodoCount(),
            update: (BuildContext context, TodoList todoList,
                    ActiveTodoCount? activeTodoCount) =>
                activeTodoCount!..update(todoList)),
        ChangeNotifierProxyProvider3<TodoList, TodoFilter, TodoSearch,
            FilteredTodos>(
          create: (context) => FilteredTodos(),
          update: (BuildContext context,
                  TodoList todoList,
                  TodoFilter todoFilter,
                  TodoSearch todoSearch,
                  FilteredTodos? filteredTodos) =>
              filteredTodos!..update(todoFilter, todoSearch, todoList),
        ),
      ],
      child: MaterialApp(
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        themeMode: ThemeMode.dark,
        title: 'TO DO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ToDoPage(),
      ),
    );
  }
}
