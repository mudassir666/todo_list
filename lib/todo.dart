import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class todo extends StatefulWidget {
  @override
  _todoState createState() => _todoState();
}

// ignore: camel_case_types
class _todoState extends State<todo> {
  TextEditingController _task = TextEditingController();

  List<String> taskList = [];
  final _savedTask = Set<String>();

  Widget viewList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,

      // padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final alreadySaved = _savedTask.contains(taskList[index]);
        return ListTile(
          leading: Text(
            "${DateFormat.yMd().format(DateTime.now())} ",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
              decoration: TextDecoration.underline,
              color: Colors.red[900],
            ),
          ),
          title: Text(
            "${taskList[index]}",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20,decoration: alreadySaved ? TextDecoration.lineThrough : TextDecoration.none,),
          ),
          tileColor: Colors.pink[100],
          trailing: Icon(
            alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
            color: alreadySaved ? Colors.red[900] : null,
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _savedTask.remove(taskList[index]);
              } else {
                _savedTask.add(taskList[index]);
              }
              print(_savedTask);
            });
          },
        );
      },
      itemCount: taskList.length,
    );
  }

  Widget build(BuildContext context) {
    List saved = _savedTask.toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("TODO LIST"),
        ),
        body: Card(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              TextFormField(
                keyboardAppearance: Brightness.dark,
                cursorColor: Colors.red[900],
                keyboardType: TextInputType.text,
                controller: _task,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.pink.shade100)),
                    hintText: "Enter A Task",
                    labelText: "TASK",
                    icon: Icon(
                      Icons.task,
                      color: Colors.pink.shade100,
                    ),
                    labelStyle: TextStyle(color: Colors.pink.shade100)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    var save = _task.text;
                    taskList.add(save);
                    print(taskList);
                  });
                },
                child: Icon(Icons.add),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              viewList(),
              SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  setState(() {
                    taskList.clear();
                  });
                },
                icon: Icon(Icons.clear),
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: taskList.length != 0
              ? ListView.builder(
                  // padding: EdgeInsets.zero,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        saved[index],
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                      ),
                      tileColor: Colors.red[100],
                    );
                  },
                  itemCount: saved.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
