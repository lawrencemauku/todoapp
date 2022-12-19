// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //
        textTheme: GoogleFonts.bevanTextTheme(),
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleCtrl = TextEditingController();
  final bodyCtrl = TextEditingController();
  final dueDateCtrl = TextEditingController();

  GetStorage store = GetStorage();

  var todoList = [].obs;
  var _now = DateTime.now();

  addTaskDialog() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Add Task'),
              content: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Column(children: [
                  TextFormField(
                    style: TextStyle(fontSize: 12),
                    controller: titleCtrl,
                    decoration: InputDecoration(labelText: 'Title', hintText: 'Enter title'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 12),
                    controller: bodyCtrl,
                    decoration: InputDecoration(labelText: 'Body', hintText: 'Enter body'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 12),
                    controller: dueDateCtrl,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                        // onDateChanged: (value) {
                        //   _now = value;
                        // }
                      );
                    },
                    decoration: InputDecoration(labelText: 'Due Date', hintText: 'Select Due Date'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () => addTask(),
                    child: Text('Add Task'),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  )
                ]),
              ),
            ));
  }

  addTask() {
    var taskObject = {
      'title': titleCtrl.text,
      'body': bodyCtrl.text,
      'dateCreated': DateTime.now().toString(),
      'isCompleted': false,
      'dueDate': dueDateCtrl.text
    };

    if (store.read('Tasks') == null) {
      todoList.clear();
      todoList.add(taskObject);
      store.write('Tasks', todoList);
    } else {
      todoList = store.read('Tasks');
      todoList.add(taskObject);
      store.remove('Tasks');
      store.write('Tasks', todoList);
    }

    print(store.read('Tasks'));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Task Added Successfully',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: Colors.green,
    ));
  }

  @override
  void initState() {
    todoList.add(store.read('Tasks'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 253, 253),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Task',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.document_scanner,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() => GridView.builder(
                  itemCount: todoList.isEmpty ? 0 : todoList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    if (todoList.isEmpty) {
                      return Center(
                        child: Text('No Data found'),
                      );
                    } else {
                      return
                          // Text(store.read('Tasks').toString());
                          Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 8,
                          color: todoList[index]['title'].toString() == true ? Colors.green : Colors.grey[200],
                          child: InkWell(
                            onTap: () {},
                            child: todoList.isEmpty
                                ? null
                                : ListTile(
                                    title: Text(
                                      todoList[index]['title'].toString(),
                                      style: GoogleFonts.dosis(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                    subtitle: SingleChildScrollView(
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              todoList[index]['body'].toString(),
                                              maxLines: 3,
                                              style: GoogleFonts.dosis(
                                                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black38),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    todoList.assign(todoList[index]['isCompleted'] == true);
                                                  },
                                                  icon: Icon(Icons.done_rounded),
                                                  color: Colors.green,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    todoList.removeAt(index);
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text(
                                                        'Task removed successfully',
                                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                                      ),
                                                      backgroundColor: Colors.red,
                                                    ));
                                                  },
                                                  icon: Icon(Icons.done_rounded),
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    }
                  })),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => addTaskDialog(),
            tooltip: 'add task',
            child: const Icon(Icons.task),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: () => store.remove('Tasks'),
            tooltip: 'clear all tasks',
            child: const Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}
