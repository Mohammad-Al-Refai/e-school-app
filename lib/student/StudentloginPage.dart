import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/student/StudentHomePage.dart';
import 'package:flutter/material.dart';

class StudentLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Raleway", primaryColor: Colors.redAccent),
      home: StudentLoginBody(),
    );
  }
}

class StudentLoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  child: Text(
                    "E-School",
                    style: TextStyle(color: Colors.redAccent, fontSize: 35),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.redAccent,
                  ),
                  height: MediaQuery.of(context).size.height * .5,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Email",
                              border: InputBorder.none),
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "PIN",
                            border: InputBorder.none),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => StudentHome()));
                          },
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Text("Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
