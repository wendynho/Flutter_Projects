import 'package:flutter/material.dart';
import 'package:list_view/widgets/todo_list_item.dart';
import '../models/todo.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                          labelText: 'Add New Task',
                          hintText: 'ex.: Study math',
                          border: OutlineInputBorder(),
                          errorText: null,
                        ),
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        setState(() {
                          Todo newTodo = Todo(
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                        });
                        todoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        primary: Colors.lightBlueAccent,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(children: [
                  Expanded(
                      child: Text('You have ${todos.length} tasks available')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: showDeleteTodosConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      primary: Colors.lightBlueAccent,
                    ),
                    child: const Text('Clean All'),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task ${todo.title} was deleted! ',
            style: const TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Undo',
          textColor: const Color(0xff00d7f3),
          onPressed: () {
            todos.insert(deletedTodoPos!, deletedTodo!);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clean All'),
        content:
            const Text('Are you sure you want to delete all these items ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: const Color(0xff00d7f3),
            ),
            child: const Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteAllTodos();
              },
              style: TextButton.styleFrom(primary: Colors.red),
              child: const Text('Clean All')),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
