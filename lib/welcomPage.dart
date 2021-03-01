import 'package:e_school_project/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Page("#Hi", "Welcom to E-School app !", Colors.blue),
      Page("#What we can do ?", "Create your school for free",
          Colors.greenAccent),
      Page("#Mangment", "you can add and delete students", Colors.purple),
      Page("#Create", "you can create exams and more...", Colors.pinkAccent)
    ];
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(30),
          child: DefaultTabController(
            length: pages.length,
            child: Column(
              children: [
                TabPageSelector(),
                Expanded(
                    child: TabBarView(
                  children: [...pages],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => WhoAreYou()));
                        },
                        child: Text("Skip"))
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget Page(String title, String centertext, Color color) {
  return Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)]),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 30),
            )
          ],
        ),
        Expanded(
          child: Center(
            child: Wrap(
              children: [
                Text(
                  centertext,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: color, fontSize: 50),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
