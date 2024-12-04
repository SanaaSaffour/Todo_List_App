import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData( // Corrected here
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ToDoScreen(),
    );
  }
}

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // List to hold tasks as a Map (description and done status)
  List<Map<String, dynamic>> _tasks = [];

  // Controller to take input from the user
  TextEditingController _controller = TextEditingController();

  // Function to add a task
  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add({'task': _controller.text, 'done': false});
      });
      _controller.clear(); // Clear the text input field
    }
  }

  // Function to delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Function to toggle the done status of a task
  void _toggleDone(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBED1E3), // Light background color for the screen
      appBar: AppBar(
        backgroundColor: Color(0XFF93AECA), // Set AppBar color
        title: Text(
          'To-Do List', // Title inside AppBar
          style: TextStyle(
            fontSize: 25, // Adjust title size
            fontWeight: FontWeight.bold,
            color: Color(0XFF0b1957),
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: Column(
        children: [
          // Centered task list
          Expanded(
            child: Center(
              child: _tasks.isEmpty
                  ? Text(
                "No tasks yet!",
                style: TextStyle(fontSize: 20, color: Color(0XFFD29E9E)),
              )
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: _tasks[index]['done'] ? Color(0XFFEAD0D1) : Colors.white,
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      title: Text(
                        _tasks[index]['task'],
                        style: TextStyle(
                          decoration: _tasks[index]['done']
                              ? TextDecoration.lineThrough
                              : null, // Line-through if done
                          color: _tasks[index]['done']
                              ? Colors.grey
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Checkbox(
                        value: _tasks[index]['done'],
                        onChanged: (bool? value) {
                          _toggleDone(index);
                        },
                        activeColor: Color(0xFFBED1E3), // Checkbox active color
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Color(0XFF0b1957)),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Input field and add button at the bottom
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter task',
                    labelStyle: TextStyle(color: Color(0XFF0b1957)), // Label color
                    hintText: 'e.g. Buy groceries',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF0b1957), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF0b1957), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBED1E3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

