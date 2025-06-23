import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Task Manager',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<String> tasks = [];
  final TextEditingController taskController = TextEditingController();

  void addTask() {
    final String task = taskController.text;
    if (task.isNotEmpty) {
      setState(() {
        tasks.add(task);
        taskController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task added!')),
        );
      });
    }
  }

  void removeTask(int index) {
    setState(() {
      String removedTask = tasks[index];
      tasks.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Removed: $removedTask')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? Center(child: Text('No tasks yet.'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: ListTile(
                          title: Text(tasks[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeTask(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

                        