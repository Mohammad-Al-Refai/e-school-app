import 'dart:convert';

import 'package:e_school_project/net/ServerConnecter.dart';
import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:e_school_project/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TecherNewStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> data = ["", "", "", ""];
    Validation validation = Validation();
    Connecter connecter = Connecter();
    return Scaffold(
        appBar: AppBar(
          title: Text("New Mather Fucker"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        data[0] = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Full Name", border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        data[1] = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Email", border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[2] = value;
                      },
                      decoration: InputDecoration(
                          labelText: "New PIN", border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data[3] = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Confirm new PIN",
                          border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        List<String> result = validation.check(
                            [data[0], data[1], data[2], data[3]],
                            ["name", "email", "pin", "pin2"]);
                        if (result.length != 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(result[0])));
                        } else {
                          // value.update();
                          if (data[2].length == 10) {
                            if (data[3].length == 10) {
                              if (data[2] == data[3]) {
                                showAlertDialog(context);
                                connecter.studentRegister(
                                    data[0], data[1], data[2], (timeout) {},
                                    (response) {
                                  var result = jsonDecode(response[1]);
                                  print(result);
                                  if (result["state"]) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => TecherHome()));
                                    haveStudentData = false;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content:
                                                Text("${data[1]} is exist")));
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "new PIN and confirm PIN is'nt equailty !")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text("PIN must be 10 numbers !")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("PIN must be 10 numbers !")));
                          }
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: WillPopScope(
      onWillPop: () {
        return Future.delayed(Duration(seconds: 2)).then((value) {
          return false;
        });
      },
      child: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5), child: Text("Loading")),
        ],
      ),
    ),
  );
}
