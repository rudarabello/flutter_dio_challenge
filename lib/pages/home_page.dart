import 'package:flutter/material.dart';

import '../controllers/todo_controller.dart';
import '../features/add_todo_page.dart';
import '../models/todo_model.dart';
import '../repositories/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TodoController(Repository());
  late List<Todo> todosList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: FutureBuilder(
        future: controller.getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("There aren't any todos yet."),
              );
            }
            todosList = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: todosList.length,
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    todosList[index].doIt();
                    await controller.updateTodo(todosList[index]);
                    setState(() {});
                  } else {
                    await controller.deleteTodo(todosList[index]);
                    setState(() {});
                  }
                },
                child: ListTile(
                  title: Text(todosList[index].title),
                  subtitle: Text(todosList[index].description),
                  trailing:
                      todosList[index].done ? const Icon(Icons.done) : null,
                ),
              ),
            );
          }
          return Center(
            child: snapshot.hasError
                ? const Text(
                    'Something wrong has just happened.\nPlease try again later.')
                : const CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const AddTodoPage(),
          ),
        )
            .then((_) {
          setState(() {});
        }),
        tooltip: 'New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
