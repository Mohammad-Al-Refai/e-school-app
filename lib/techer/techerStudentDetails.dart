import 'package:e_school_project/techer/techerEditStudent.dart';
import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:flutter/material.dart';

class TecherStudentDetails extends StatelessWidget {
  String id;

  TecherStudentDetails(String _id) {
    this.id = _id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text("About Student"),
            actions: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TecherEditStudent(this.id)));
                  })
            ],
            centerTitle: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        subtitle: Text(
                          "Mohamamd Al Refai",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(Icons.person, color: Colors.white),
                        title: Text("Name",
                            style: TextStyle(color: Colors.white))),
                    ListTile(
                        subtitle: Text(
                          "raslk325@gamil.com",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(Icons.email, color: Colors.white),
                        title: Text("Email",
                            style: TextStyle(color: Colors.white))),
                    ListTile(
                        subtitle: Text(
                          "3234",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(Icons.lock_outline, color: Colors.white),
                        title:
                            Text("PIN", style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                margin: EdgeInsets.all(10),
                child: Text("Exams completed:"),
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: RefreshIndicator(
                      color: Colors.blue,
                      onRefresh: () {
                        return Future.delayed(Duration(seconds: 2));
                      },
                      child: ListView(children: [
                        ListTile(
                          leading: Icon(Icons.web_asset_outlined),
                          title: Text("Exam 23"),
                          subtitle: Text("2021/03/3"),
                        ),
                        ListTile(
                          leading: Icon(Icons.web_asset_outlined),
                          title: Text("Exam 42"),
                          subtitle: Text("2021/03/3"),
                        ),
                      ])))
            ],
          ))
        ],
      ),
    );
  }
}
