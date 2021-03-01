import 'dart:convert';
import 'dart:ui';

import 'package:e_school_project/main.dart';
import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/student/StudentHomePage.dart';
import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:e_school_project/techer/techerRegister.dart';
import 'package:e_school_project/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../net/ServerConnecter.dart';

class TecherLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegExp email_V = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    // var state = Provider.of<EmailController>(context);
    Validation validation = Validation();
    Connecter connecter = Connecter();

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: ChangeNotifierProvider(
        create: (_) => LoginController(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Text(
                        "E-School",
                        style: TextStyle(color: Colors.blue, fontSize: 35),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black45, blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height * .5,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: MediaQuery.of(context).size.width * .9 + 10,
                      child: Consumer<LoginController>(
                        builder: (c, state, w) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: TextField(
                                    onChanged: (v) {
                                      state.email = v;
                                      state.updatePassword();
                                    },
                                    style: TextStyle(color: Colors.black),
                                    cursorColor: Colors.blue,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.email),
                                        fillColor: Colors.white38,
                                        filled: true,
                                        labelText: "Email",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: TextField(
                                    onChanged: (v) {
                                      state.password = v;
                                      state.updatePassword();
                                    },
                                    obscureText: true,
                                    style: TextStyle(color: Colors.black),
                                    cursorColor: Colors.blue,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock),
                                        fillColor: Colors.white38,
                                        filled: true,
                                        labelText: "Password",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    var x = validation
                                        .check([state.password], ["Password"]);

                                    if (email_V.hasMatch(state.email)) {
                                      if (x.isEmpty) {
                                        showAlertDialog(context);
                                        connecter.teacherLogin(
                                            state.email, state.password,
                                            (timeout) {
                                          print(timeout);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.grey,
                                                  content: Text("Time out")));
                                        }, (data) {
                                          Navigator.pop(context);
                                          if (data[0]) {
                                            var result = jsonDecode(data[1]);
                                            print(result);
                                            if (result["state"]) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text("done")));
                                              connecter
                                                  .setToken(result["token"]);
                                              connecter.setUserState(true);
                                              connecter.setUserType("teacher");
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          TecherHome()));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Email is not found")));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content:
                                                        Text("No Internet !")));
                                          }
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(x[0])));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content:
                                                  Text("Email is not valid")));
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(color: Colors.blue)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Login",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20))
                                      ],
                                    ),
                                  )),
                              Container(
                                child: Wrap(
                                  children: [
                                    Text(
                                      "if you don't have account you can ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "create new account",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    TecherRegister()));
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class LoginController extends ChangeNotifier {
  String email = "";
  String password = "";
  updateEmail() {
    email = email;
    notifyListeners();
  }

  updatePassword() {
    password = password;
    notifyListeners();
  }
}
