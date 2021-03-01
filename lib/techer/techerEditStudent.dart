import 'package:e_school_project/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TecherEditStudent extends StatelessWidget {
  String id;
  TecherEditStudent(String _id) {
    this.id = _id;
  }
  List<String> data = ["", "", "", ""];
  @override
  Widget build(BuildContext context) {
    Validation validation = Validation();
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Student"),
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
                                
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Edited Please Swap Up !")));
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
                        "Save Changes",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

class EditStudentController extends ChangeNotifier {
  String name = "";
  String email = "";
  String pin = "";
  String confirmPin = "";
}
