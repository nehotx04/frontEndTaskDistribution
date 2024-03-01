import 'package:flutter/material.dart';
import 'package:home_tasks/models/Task.dart';
import 'package:home_tasks/pages/TaskForm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Task> taskList = [];

  @override
  void initState() {
    super.initState();
    getDay();
  }

  Future<void> getDay() async {
    final res =
        await http.get(Uri.parse('http://192.168.1.106:8000/api/tasks/day'));
    if (res.statusCode == 200) {
      String resBody = utf8.decode(res.bodyBytes);
      List<dynamic> data = json.decode(resBody);
      List<Task> tasks = data
          .map((task) => Task(
              task['id'],
              task['name'],
              task['description'],
              task['user_id'],
              task['completed'] == 1,
              task['week_day'],
              task['user']))
          .toList();

      setState(() {
        taskList = tasks;
      });

      print('Request success: ${resBody}');
    } else {
      print("Error in request: ${res.statusCode}");
    }
  }

  Future<void> completeTask(int id) async {
    final res = await http
        .put(Uri.parse('http://192.168.1.106:8000/api/tasks/' + id.toString()));
    if (res.statusCode == 200) {
      print("Request successfull");
    } else {
      print("Request error: ${res.statusCode}");
    }
  }

  Future<void> _refresh() async {
    setState(() {
      getDay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Inicio')),
          ),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: taskList.length + 1,
              itemBuilder: (context, index) {
                if (index < taskList.length) {
                  return Card.outlined(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                taskList[index].name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                taskList[index].user,
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                          Checkbox(
                              value: taskList[index].completed,
                              onChanged: (bool? newValue) => {
                                    setState(() {
                                      taskList[index].completed =
                                          newValue ?? false;
                                    }),
                                    completeTask(taskList[index].id)
                                  }),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Icon(Icons.add),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(CircleBorder()),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TaskForm()));
                        },
                      )
                    ],
                  );
                }
              },
            ),
          )),
    );
  }
}
