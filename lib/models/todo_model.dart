import 'dart:convert';

class Todo {
  String? _id;
  String title;
  String description;
  bool _done;

  Todo({
    required this.title,
    required this.description,
    bool done = false,
    String? id,
  })  : _done = done,
        _id = id;

  String? get id => _id;
  bool get done => _done;

  void doIt() => _done = !_done;

  void undoIt() => _done = !_done;

  factory Todo.fromMap(Map<String, dynamic> source) => Todo(
      title: source['title'],
      description: source['description'],
      done: source['done'],
      id: source['_id']);

  factory Todo.fromJson(json) => Todo.fromMap(json);

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'done': _done,
      };

  String toJson() => jsonEncode(toMap());
}
