import 'dart:async';
import 'dart:convert';

import 'package:e_school_project/student/StudentHomePage.dart';
import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:e_school_project/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../net/ServerConnecter.dart';

class TecherRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TecherLoginBody();
  }
}

class TecherLoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Validation validation = Validation();
    Connecter connecter = Connecter();
    String email_V =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String password_V =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    return ChangeNotifierProvider(
      create: (_) => RegisterController(),
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
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    Consumer<RegisterController>(
                      builder: (k, state, t) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height * .7,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          width: MediaQuery.of(context).size.width * .9 + 10,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: TextField(
                                    onChanged: (v) =>
                                        state.updateValue("name", v),
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        labelText: "Name",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: TextField(
                                    onChanged: (v) =>
                                        state.updateValue("email", v),
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.email),
                                        labelText: "Email",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: TextField(
                                    onChanged: (v) =>
                                        state.updateValue("password", v),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock),
                                        labelText: "Password",
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
                                    onChanged: (v) =>
                                        state.updateValue("confirmPassword", v),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock),
                                        labelText: "Confirm password",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (state.formData["name"].length > 5) {
                                      if (validation.IsValidate(
                                          email_V, state.formData["email"])) {
                                        if (validation.IsValidate(password_V,
                                            state.formData["password"])) {
                                          if (state.formData["password"] ==
                                              state.formData[
                                                  "confirmPassword"]) {
                                            print("you can create now !");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.blue,
                                              content: Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white,
                                                        semanticsLabel:
                                                            "Registering ...",
                                                        strokeWidth: 2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            "Registering ..."),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                            connecter.teacherRegister(
                                                state.formData["name"],
                                                state.formData["email"],
                                                state.formData["password"],
                                                (timeout) {}, (data) {
                                              if (data[0]) {
                                                Navigator.pop(context);
                                                var result =
                                                    jsonDecode(data[1]);
                                                print(result);
                                                if (result["state"]) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content:
                                                              Text("done")));
                                                  connecter.setToken(
                                                      result["token"]);
                                                  connecter.setUserState(true);
                                                  connecter
                                                      .setUserType("teacher");
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
                                                              "Email is Exist")));
                                                }
                                              } else {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                            "No Internet !")));
                                              }
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Passwords is not same")));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Password is week !  , use 0-9 or /+*&^%£ and UpperCase word and >= 8 ")));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Email is not valid")));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content:
                                                  Text("Name is not valid")));
                                    }
                                    // Navigator.popUntil(
                                    //     context, (route) => false);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => TecherHome()));
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
                                        Text("Register",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class RegisterController extends ChangeNotifier {
  Map formData = {
    "name": "",
    "email": "",
    "password": "",
    "confirmPassword": "",
  };
  updateValue(label, value) {
    formData[label] = value;
    notifyListeners();
  }
}
