import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {

    final String taskName;
    final bool taskCompleted;
    Function(bool?)? onChanged;

   

ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,

});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged),
              Text(taskName),
            ],
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 156, 51, 226),
            borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(18.0),
          
      ),
    );
  }
}