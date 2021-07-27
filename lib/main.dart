import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark, primaryColor: Colors.grey[700]),
      home: todo(),
    );
  }
}

// ignore: must_be_immutable
// ignore: camel_case_types
class todo extends StatefulWidget {
  @override
  _todoState createState() => _todoState();
}

// ignore: camel_case_types
class _todoState extends State<todo> {
  TextEditingController _task = TextEditingController();

  final _taskList = <String>[];
  final _savedTask = Set<String>();

  Widget viewList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,

      // padding: EdgeInsets.zero,
      itemBuilder: (context, index) {

        return buildList(_taskList[index]);
      },
      itemCount: _taskList.length,
    );
  }

  Widget buildList(String task) {
    final alreadySaved = _savedTask.contains(task);
    return ListTile(
      title: Text(
        task.toUpperCase(),
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
      ),
      tileColor: Colors.pink[100],
      trailing: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.blueAccent : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
          _savedTask.remove(task);
        } else {
          _savedTask.add(task);
        }
        print(_savedTask);
        });
        
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TODO LIST"),
        ),
        body: Card(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _task,
                decoration: InputDecoration(
                    hintText: "Enter A Task",
                    labelText: "TASK",
                    icon: Icon(Icons.task)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    var save = _task.text;
                    _taskList.add(save);
                    print(_taskList);
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
                    _taskList.clear();
                  });
                },
                icon: Icon(Icons.clear),
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: _taskList.length != 0
              ? ListView.builder(
                  // padding: EdgeInsets.zero,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _taskList[index],
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                      ),
                      tileColor: Colors.amber[100],
                    );
                  },
                  itemCount: _taskList.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
