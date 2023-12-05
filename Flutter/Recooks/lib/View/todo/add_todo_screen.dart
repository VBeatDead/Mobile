import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prak/Controller/DatabaseController.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  @override
  Widget build(BuildContext context) {
    backgroundColor:
    context.watch<ThemeNotifier>().isDarkMode
        ? Color(0xFF424242)
        : Color.fromARGB(255, 248, 241, 241);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<ThemeNotifier>().isDarkMode
            ? Color(0xFF424242)
            : Colors.orange,
        title: const Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Title";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _title = newValue ?? "Title",
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Description"),
                  onSaved: (newValue) =>
                      _description = newValue ?? "description",
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        bool result =
                            await DatabaseController.instance.createTodo(
                          title: _title,
                          description: _description,
                        );
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Added todo successfully")),
                          );

                          Navigator.pop(context);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  child: const Text("Add Todo"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                )
              ],
            )),
      ),
    );
  }
}
