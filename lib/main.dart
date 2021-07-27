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
          title: Text(
            taskList[index],
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
                        taskList[index],
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                      ),
                      tileColor: Colors.amber[100],
                    );
                  },
                  itemCount: taskList.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
