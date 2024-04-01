import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box? _todoBox;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox('todo_Box').then((value) {
      setState(() {
        _todoBox = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          'Note it',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: BuildUi(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade300,
        onPressed: () => displaytextInputDialog(context),
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget BuildUi() {
    if (_todoBox == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ValueListenableBuilder(
        valueListenable: _todoBox!.listenable(),
        builder: (context, box, widget) {
          final todoKeys = box.keys.toList();

          return Container(
            decoration: BoxDecoration(color: Colors.black),
            child: ListView.builder(
              itemCount: todoKeys.length,
              itemBuilder: (context, index) {
                Map todos = _todoBox!.get(todoKeys[index]);

                DateTime time = DateTime.parse(todos['time']);

                Map todo = _todoBox!.get(todoKeys[index]);
                return ListTile(
                  title: Text(
                    todo['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(time),
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        await _todoBox!.delete(todoKeys[index]);
                      },
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: Colors.white,
                      )),
                  leading: Checkbox(
                    value: todo['isDone'],
                    onChanged: (value) async {
                      todo['isDone'] = value;
                      await _todoBox!.put(todoKeys[index], todo);
                    },
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> displaytextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Todo',
          ),
          content: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'ToDo....'),
          ),
          actions: [
            MaterialButton(
              color: Colors.purple.shade300,
              onPressed: () {
                _todoBox?.add({
                  'content': textEditingController.text.trim(),
                  'time': DateTime.now().toIso8601String(),
                  'isDone': false,
                });
                Navigator.pop(context);
                textEditingController.clear();
              },
              child: Text('Ok'),
            )
          ],
        );
      },
    );
  }
}
