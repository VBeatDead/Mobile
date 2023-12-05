import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prak/Controller/DatabaseController.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:prak/Model/todo_model.dart';
import 'package:prak/View/todo/add_todo_screen.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoModel> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<TodoModel> todos = await DatabaseController.instance.fetchTodos();
    setState(() {
      data = todos;
    });
  }

  Future<void> deleteTodo(String documentId) async {
    bool deleted = await DatabaseController.instance.deleteTodo(documentId);
    if (deleted) {
      setState(() {
        data.removeWhere((todo) => todo.documentId == documentId);
      });
    }
  }

  Future<void> editTodo(TodoModel todo) async {
    TextEditingController titleController =
        TextEditingController(text: todo.title);
    TextEditingController descriptionController =
        TextEditingController(text: todo.description);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                todo.title = titleController.text;
                todo.description = descriptionController.text;
                await DatabaseController.instance.updateTodo(todo);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color(0xFF424242)
          : Color.fromARGB(255, 248, 241, 241);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color(0xFF424242)
          : Colors.orange,
        title: Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => const AddTodoScreen());
        },
      ),
      body: data.isEmpty
          ? Center(
              child: Text("No todo added"),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(data[index].title),
                subtitle: Text(data[index].description),
                leading: Checkbox(
                  value: data[index].isDone,
                  onChanged: (value) {
                    setState(() {
                      data[index].isDone = value!;
                    });
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${data[index].createAt.day}-${data[index].createAt.month}",
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTodo(data[index].documentId);
                        print(
                            "Delete button pressed for document ID: ${data[index].documentId}");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        editTodo(data[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
