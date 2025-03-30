import 'package:flutter/material.dart';
import 'package:todo_app/util/ToDoTile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  List todoList = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load saved tasks
  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTasks = prefs.getString('todoList');
    if (savedTasks != null) {
      setState(() {
        todoList = jsonDecode(savedTasks);
      });
    }
  }

  // Save tasks
  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('todoList', jsonEncode(todoList));
  }

  void changeState(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
    saveTasks(); // Save after change
  }

  void addTask(String task) {
    setState(() {
      todoList.add([task, false]);
    });
    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To Do List'),
        backgroundColor: const Color.fromARGB(255, 156, 51, 226),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: todoList[index][0],
                  taskCompleted: todoList[index][1],
                  onChanged: (value) => changeState(value, index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter new task',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      addTask(controller.text);
                      controller.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
