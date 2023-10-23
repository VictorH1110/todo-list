import 'package:hive_flutter/hive_flutter.dart';

class TasksDataBase {
  final toDoBox = Hive.box('toDoBox');

  List data = [];

  void initialData() {
    data.add({'task': 'Example', 'completed': false});
  }

  void loadData() {
    data = toDoBox.get('ToDoList');
  }

  void updateData() {
    toDoBox.put('ToDoList', data);
  }
}
