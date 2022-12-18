// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //

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
                    decoration: InputDecoration(labelText: 'Title', hintText: 'Enter title'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(labelText: 'Body', hintText: 'Enter body'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text('Add Task'),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  )
                ]),
              ),
            ));
  }

  addTask() {
    // BoxStorage store = BoxStorage();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      body: Center(
        child: Column(
          //

          //

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTaskDialog(),
        tooltip: 'Increment',
        child: const Icon(Icons.task),
      ),
    );
  }
}
