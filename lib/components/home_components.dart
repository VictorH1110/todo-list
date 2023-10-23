import 'package:flutter/material.dart';

// ToDoTile
class ToDoTile extends StatelessWidget {
  final String text;
  final bool completed;
  final Function(bool?)? onCheckBoxChanged;
  final Function()? onDelete;

  const ToDoTile({
    super.key,
    required this.text,
    required this.completed,
    required this.onCheckBoxChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child: Row(
              children: [
                Checkbox(
                  value: completed,
                  onChanged: onCheckBoxChanged,
                ),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 18,
                        decoration: completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
              color: Colors.red,
            ),
          ),
        ]),
        onPressed: () {});
  }
}

// CustomButton
class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.border = 10});
  final Widget child;
  final double border;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border),
            ),
          ),
        ),
        child: child);
  }
}

class AddTaskForm extends StatelessWidget {
  const AddTaskForm(
      {super.key, required this.onSave, required this.controller});
  final VoidCallback onSave;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Enter your task',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(onPressed: onSave, child: const Text('Save')),
              CustomButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
            ],
          ),
        )
      ],
    );
  }
}
