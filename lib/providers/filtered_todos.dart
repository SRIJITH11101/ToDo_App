// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_filter.dart';
import 'package:todo_app/providers/todo_list.dart';
import 'package:todo_app/providers/todo_search.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredtodos;

  FilteredTodoState({required this.filteredtodos});

  factory FilteredTodoState.initial() {
    return FilteredTodoState(filteredtodos: []);
  }

  @override
  List<Object> get props => [filteredtodos];

  @override
  bool get stringify => true;

  FilteredTodoState copyWith({
    List<Todo>? filteredtodos,
  }) {
    return FilteredTodoState(
      filteredtodos: filteredtodos ?? this.filteredtodos,
    );
  }
}

class FilteredTodos with ChangeNotifier {
  FilteredTodoState _state = FilteredTodoState.initial();
  FilteredTodoState get state => _state;

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> _filteredTodos;
    switch (todoFilter.state.filter) {
      case Filter.ACTIVE:
        _filteredTodos =
            todoList.state.todos.where((todo) => !todo.completed).toList();
        break;
      case Filter.COMPLETED:
        _filteredTodos =
            todoList.state.todos.where((todo) => todo.completed).toList();
        break;
      case Filter.ALL:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
          .toList();
    }

    _state = _state.copyWith()
  }
}
