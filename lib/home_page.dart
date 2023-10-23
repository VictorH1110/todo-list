import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/components/home_components.dart';
import 'package:todo_list/db/tasks_db.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = true;
  TasksDataBase db = TasksDataBase();
  final toDoBox = Hive.box('toDoBox');

  @override
  void initState() {
    if (db.toDoBox.get('ToDoList') == null) {
      db.initialData();
    } else {
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController taskController = TextEditingController();

    void onSaveTask() {
      db.data.add({'task': taskController.text, 'completed': false});
      db.updateData();
      Navigator.of(context).pop();
    }

    void onDeleteTask(int index) {
      setState(() {
        db.data.removeAt(index);
        db.updateData();
      });
    }

    void showAlertDialog(Widget content) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.15,
                  child: content),
            );
          });
    }

    void changeCheckBox(int index) {
      setState(() {
        db.data[index]['completed'] = !db.data[index]['completed'];
        db.updateData();
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight,
          margin: EdgeInsets.only(top: screenHeight * 0.03),
          child: ListView.builder(
            itemCount: db.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: SizedBox(
                  height: screenHeight * 0.12,
                  child: ToDoTile(
                    text: db.data[index]['task'],
                    completed: db.data[index]['completed'],
                    onCheckBoxChanged: (value) => changeCheckBox(index),
                    onDelete: () => onDeleteTask(index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAlertDialog(
          AddTaskForm(
            controller: taskController,
            onSave: onSaveTask,
          ),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
