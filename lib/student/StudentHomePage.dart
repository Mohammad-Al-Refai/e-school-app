import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/student/StudentExamPage.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Raleway",
            primaryColor: Colors.red,
            accentColor: Colors.white),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            bottom: TabBar(
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(icon: Icon(Icons.card_travel), text: "Exams"),
                Tab(icon: Icon(Icons.watch_later), text: "Done"),
                Tab(
                  icon: Icon(Icons.messenger),
                  text: "Massenger",
                ),
              ],
            ),
            title: Text("E-School"),
          ),
          body: TabBarView(
            children: [
              Exams(),
              Done(),
              Massenger(),
            ],
          ),
        ),
      ),
    );
  }
}

//Page ToDoPage
class Exams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExamItem(context, "Exam 5223", "236236", "2021/04/2"),
        ExamItem(context, "Exam 2042", "23623", "2021/04/2"),
        ExamItem(context, "Exam 5264", "4363246", "2021/04/2")
      ],
    );
  }
}

//Page LodaingToDoPage
class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DoneItem("Exam 5223", "2021/04/2", "28141"),
        DoneItem("Exam 2042", "2021/04/2", "28141"),
        DoneItem("Exam 5264", "2021/04/2", "28141")
      ],
    );
  }
}
//Page DonePage

class Massenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Soon..."),
    );
  }
}

// Item DoneItem
class DoneItem extends Widget {
  String title;
  String date;
  String result;
  DoneItem(String _title, String _date, String _result) {
    this.title = _title;
    this.date = _date;
    this.result = _result;
  }
  @override
  Element createElement() {
    return StatelessElement(GestureDetector(
      onTap: () {
        print(this.title);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Done",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Result: ${result}",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

// Item LoadingItem

class ExamItem extends Widget {
  String title;
  String date;
  String id;
  BuildContext context;

  ExamItem(BuildContext _context, String _title, String _id, String _date) {
    this.title = _title;
    this.date = _date;
    this.context = _context;
    this.id = _id;
  }
  @override
  Element createElement() {
    return StatelessElement(GestureDetector(
      onTap: () {
        print(this.title);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(
                    Icons.fiber_new_sharp,
                    color: Colors.green,
                  ),
                ),
                Text(
                  this.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  this.date,
                  style: TextStyle(color: Colors.grey),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                StudentExamPage(this.id, this.title)));
                  },
                  child: Text("Start Exam"),
                  textColor: Colors.green,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
