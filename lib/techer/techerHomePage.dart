import 'dart:convert';

import 'package:e_school_project/techer/techerExamDetails.dart';
import 'package:e_school_project/techer/techerNewHomeWork.dart';
import 'package:e_school_project/techer/techerNewStudent.dart';
import 'package:e_school_project/techer/techerStudentDetails.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../net/ServerConnecter.dart';

bool haveStudentData = false;
List<Student> students = [];

class TecherHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 3,
        child: MaterialApp(
          theme: ThemeData(fontFamily: "Raleway", accentColor: Colors.white),
          home: Scaffold(
            appBar: AppBar(
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CreateNewHomeWork()));
                    },
                    child: Text(
                      "Create New Exam",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              bottom: TabBar(
                onTap: (index) {
                  // Tab index when user select it, it start from zero
                },
                tabs: [
                  Tab(
                      icon: Icon(Icons.people),
                      child: Text(
                        "My Students",
                        textAlign: TextAlign.center,
                      )),
                  Tab(
                      icon: Icon(Icons.wysiwyg_outlined),
                      child: Text(
                        "My Exams",
                        textAlign: TextAlign.center,
                      )),
                  Tab(
                    icon: Icon(Icons.done_all),
                    child: Text(
                      "Received",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              title: Text("E School"),
            ),
            body: TabBarView(
              children: [
                MyStudents(),
                MyHomeWrok(),
                HomeWorkDone(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Page ToDoPage
class MyStudents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyStudentsController(),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TecherNewStudent()));
            },
            child: Icon(Icons.group_add_rounded),
          ),
          body: Consumer<MyStudentsController>(
            builder: (k, state, w) {
              return RefreshIndicator(
                color: Colors.blue,
                onRefresh: () {
                  state.updateStudents((timeout) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.grey,
                        content: Text("Time out")));
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Loading ...")));
                  return Future.delayed(Duration(seconds: 3));
                },
                child: GridView.count(
                  crossAxisCount: 2,
                  children: students.length == 0
                      ? [
                          Center(
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Text("No Students",
                                    style: TextStyle(fontSize: 20))),
                          )
                        ]
                      : students
                          .map((s) => s.name == null
                              ? Center(
                                  child: Text(
                                    "no internet !",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : StudentItem(context, s.name, s.id))
                          .toList(),
                ),
              );
            },
          )),
    );
  }
}

//Page LodaingToDoPage
class MyHomeWrok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.blue,
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1));
      },
      child: ListView(
        children: [
          HomeWorkItem(context, "Exam 5223", "2021/04/2"),
          HomeWorkItem(context, "Exam 2042", "2021/04/2"),
          HomeWorkItem(context, "Exam 5264", "2021/04/2")
        ],
      ),
    );
  }
}
//Page DonePage

class HomeWorkDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.blue,
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1));
      },
      child: ListView(
        children: [
          HomeWorkDoneItem("Exam 5223", "Mohammad", "2021/04/2", "432142"),
          HomeWorkDoneItem("Exam 2042", "Ali", "2021/04/2", "432142"),
          HomeWorkDoneItem("Exam 5264", "Ahmad", "2021/04/2", "432142")
        ],
      ),
    );
  }
}

// Item DoneItem
class HomeWorkDoneItem extends Widget {
  String homeWorkName;
  String date;
  String id;
  String studentName;
  HomeWorkDoneItem(
      String _homeWorkName, String _studentName, String _date, String _id) {
    this.homeWorkName = _homeWorkName;
    this.date = _date;
    this.id = _id;
    this.studentName = _studentName;
  }
  @override
  Element createElement() {
    return StatelessElement(GestureDetector(
      onTap: () {
        print(this.homeWorkName);
      },
      child: Container(
        height: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 5)]),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.homeWorkName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Received from",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.all(10), child: Text(this.studentName)),
                Container(margin: EdgeInsets.all(10), child: Text(this.date)),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child:
                        Text("Results", style: TextStyle(color: Colors.white)))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

// Item LoadingItem

class HomeWorkItem extends Widget {
  String title;
  String date;
  String id;
  BuildContext context;
  HomeWorkItem(BuildContext _context, String _title, String _date) {
    this.title = _title;
    this.date = _date;
    this.context = _context;
  }
  @override
  Element createElement() {
    return StatelessElement(Container(
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 5)]),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Text(this.date),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TecherStudentExamDetails(this.id)));
                  },
                  child: Text(
                    "Details",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}

// Item TodoItem
class StudentItem extends Widget {
  BuildContext context;
  String name;
  String id;
  StudentItem(BuildContext _context, String _name, String _id) {
    this.name = _name;
    this.id = _id;
    this.context = _context;
  }
  @override
  Element createElement() {
    return StatelessElement(GestureDetector(
      onTap: () {
        print(this.name);
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 2)]),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              this.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TecherStudentDetails(this.id)));
                },
                child: Text(
                  "Details",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    ));
  }
}

class MyStudentsController extends ChangeNotifier {
  MyStudentsController() {
    print(haveStudentData);
    Connecter connecter = Connecter();
    if (haveStudentData == false) {
      connecter.getStudents((timeout) {
        print("time out");
      }, (result) {
        if (result[0] != false) {
          var data = jsonDecode(result[1]);
          if (data["state"]) {
            print(data["data"]);
            if (data["data"] != false) {
              data["data"]
                  .forEach((s) => students.add(Student(s["name"], s["_id"])));
            }
            notifyListeners();
          }
          haveStudentData = true;
        } else {
          students.add(Student(null, null));
          notifyListeners();
        }
      });
    }
  }

  updateStudents(timeout) {
    students = [];
    print(haveStudentData);
    Connecter connecter = Connecter();

    connecter.getStudents((_timeout) {
      timeout(_timeout);
    }, (result) {
      print(result);
      if (result[0] != false) {
        var data = jsonDecode(result[1]);
        if (data["state"]) {
          print(data["data"]);
          if (data["data"] != false) {
            data["data"]
                .forEach((s) => students.add(Student(s["name"], s["_id"])));
          }
          notifyListeners();
        }
        haveStudentData = true;
      } else {
        students.add(Student(null, null));
        notifyListeners();
        timeout(true);
      }
    });

    notifyListeners();
  }
}

class Student {
  String name;
  String id;

  Student(String _name, String _id) {
    this.id = _id;
    this.name = _name;
  }
}
