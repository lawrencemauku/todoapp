// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewToDoItem extends StatefulWidget {
  const NewToDoItem({super.key});

  @override
  State<NewToDoItem> createState() => _NewToDoItemState();
}

class _NewToDoItemState extends State<NewToDoItem> with TickerProviderStateMixin {
  var _controller;
  var _animation;
  final titleCtrl = TextEditingController();
  final bodyCtrl = TextEditingController();
  final dueDateCtrl = TextEditingController();

  var reminder = false.obs;
  var notif = false.obs;

  GetStorage store = GetStorage();

  var todoList = [].obs;
  var _now = DateTime.now();

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

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Task Added Successfully',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: Colors.green,
    ));
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    )..animateTo(1, duration: const Duration(seconds: 2), curve: Curves.easeInOut);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Add new task',
                  style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.green[100],
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 12),
                      controller: titleCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Title', border: InputBorder.none, hintText: 'Enter title'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.green[100],
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 12),
                      controller: bodyCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Body', border: InputBorder.none, hintText: 'Enter body'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.green[100],
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 12),
                                  controller: dueDateCtrl,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365)),
                                      // onDateChanged: (value) {
                                      //   _now = value;
                                      // }
                                    );
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Due Date',
                                    border: InputBorder.none,
                                    hintText: 'Select Due Date',
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.green[100],
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 12),
                                  controller: dueDateCtrl,
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        initialEntryMode: TimePickerEntryMode.input);
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Due Time', border: InputBorder.none, hintText: 'Select Due Time'),
                                ),
                              ),
                              const Icon(
                                Icons.timer,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  color: Colors.green[100],
                  elevation: 0,
                  child: SwitchListTile.adaptive(
                      value: reminder.value,
                      activeColor: Colors.pink,
                      inactiveTrackColor: Colors.white,
                      title: const Text('set reminder'),
                      onChanged: (val) {
                        val != val;
          
                        setState(() {
                          reminder.value = val;
                        });
          
                        print(reminder.value);
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'How do you want to be notified?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Card(
                  color: Colors.green[100],
                  elevation: 0,
                  child: SwitchListTile.adaptive(
                      value: notif.value,
                      activeColor: Colors.pink,
                      inactiveTrackColor: Colors.white,
                      title: notif.value == true ? const Text('Email') : const Text('Notifications'),
                      onChanged: (val) {
                        val != val;
          
                        setState(() {
                          notif.value = val;
                        });
          
                        print(notif.value);
                      }),
                ),
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: _size.width / 1.6,
                    child: MaterialButton(
                      onPressed: () => addTask(),
                      child: Text(
                        'Add Task'.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
