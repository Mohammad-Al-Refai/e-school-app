import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:flutter/material.dart';

class TecherStudentExamDetails extends StatelessWidget {
  String id;

  TecherStudentExamDetails(String _id) {
    this.id = _id;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => TecherHome()));
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text("About Exam"),
              actions: [
                Tooltip(
                    message: 'Delete Exam',
                    child:
                        IconButton(icon: Icon(Icons.delete), onPressed: () {}))
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
                            "Exam24",
                            style: TextStyle(color: Colors.white),
                          ),
                          leading:
                              Icon(Icons.web_asset_sharp, color: Colors.white),
                          title: Text("Exam Name",
                              style: TextStyle(color: Colors.white))),
                      ListTile(
                          subtitle: Text(
                            "2021/03/4",
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: Icon(Icons.date_range, color: Colors.white),
                          title: Text("Published date",
                              style: TextStyle(color: Colors.white))),
                      ListTile(
                          subtitle: Text(
                            "3242351",
                            style: TextStyle(color: Colors.white),
                          ),
                          leading:
                              Icon(Icons.info_rounded, color: Colors.white),
                          title: Text("ID",
                              style: TextStyle(color: Colors.white))),
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
                  child: Text("completed by :"),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: RefreshIndicator(
                    color: Colors.blue,
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 2));
                    },
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Mohammad"),
                          subtitle: Text("2021/03/3"),
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Ali"),
                          subtitle: Text("2021/03/3"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
