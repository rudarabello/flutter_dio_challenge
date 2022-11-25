import 'package:flutter/material.dart';

import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import '../repositories/repository.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final controller = TodoController(Repository());
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Todo')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Title'),
              style: const TextStyle(fontSize: 18),
              controller: titleController,
              validator: (value) {
                return titleController.text.isEmpty ? 'Required field' : null;
              },
            ),
            const Divider(),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Description'),
              controller: descController,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing data...')),
                      );
                      await controller.createTodo(
                        Todo(
                            title: titleController.text,
                            description: descController.text),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('SALVAR'),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
