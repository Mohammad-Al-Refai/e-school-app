import 'package:e_school_project/net/ServerConnecter.dart';
import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/student/StudentHomePage.dart';
import 'package:e_school_project/student/StudentloginPage.dart';
import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:e_school_project/techer/techerLoginPage.dart';
import 'package:e_school_project/welcomPage.dart';
import 'package:flutter/material.dart';

import 'mySplashScreen.dart';

void main() {
  runApp(SplashPage());
}

class WhoAreYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  Connecter connecter = Connecter();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Who Are You?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TecherLogin()));
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: Text("Teacher",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 20)),
                    )),
                Text(
                  "ــــ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StudentLogin()));
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: Text("Student",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 20)),
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
