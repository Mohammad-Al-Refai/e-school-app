import 'package:e_school_project/db/db.dart';
import 'package:e_school_project/stateMangement/Sates.dart';
import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/techer/techerNewHomeWork.dart';
import 'package:e_school_project/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      "mark": "",
      "text": "",
      "o1": "",
      "o2": "",
      "o3": "",
      "currect": ""
    };
    DataBaseConnection db = DataBaseConnection();
    Validation validation = Validation();
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('you will miss this question data ?'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("NO"),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Text("YES"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("New Q"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 5)
                        ]),
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            data["mark"] = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none, labelText: "Mark"),
                        ),
                        TextField(
                          onChanged: (value) {
                            data["text"] = value;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: "...",
                              border: InputBorder.none,
                              labelText: "Text"),
                        ),
                        Container(
                          height: 250,
                          child: Column(
                            children: [
                              ListTile(
                                  title: TextField(
                                    onChanged: (value) {
                                      data["o1"] = value;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Option A",
                                    ),
                                  ),
                                  leading: Text(
                                    "A -",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              ListTile(
                                  title: TextField(
                                      onChanged: (value) {
                                        data["o2"] = value;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Option B")),
                                  leading: Text(
                                    "B -",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              ListTile(
                                  title: TextField(
                                    onChanged: (value) {
                                      data["o3"] = value;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Option C",
                                    ),
                                  ),
                                  leading: Text(
                                    "C -",
                                    style: TextStyle(fontSize: 20),
                                  ))
                            ],
                          ),
                        ),

                        // ignore: deprecated_member_use

                        Container(
                            width: 200,
                            child: DropdownButtonFormField(
                                hint: Text("Currect Answer"),
                                items: [
                                  DropdownMenuItem(
                                    value: "A",
                                    child: Text("A"),
                                  ),
                                  DropdownMenuItem(
                                    value: "B",
                                    child: Text("B"),
                                  ),
                                  DropdownMenuItem(
                                    value: "C",
                                    child: Text("C"),
                                  ),
                                ],
                                onChanged: (value) {
                                  data["currect"] = value;
                                }))
                      ],
                    )),
                FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      List<String> res = validation.check([
                        data["mark"],
                        data["text"],
                        data["o1"],
                        data["o2"],
                        data["o3"],
                        data["currect"]
                      ], [
                        "Mark",
                        "Text",
                        "Option A",
                        "Option B",
                        "Option C",
                        "Currect Answer"
                      ]);
                      print(res);
                      if (res.length != 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(res[0])));
                      } else {
                        db.insertQuestion(
                            data["mark"],
                            data["text"],
                            data["o1"],
                            data["o2"],
                            data["o3"],
                            data["currect"]);
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateNewHomeWork()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please update the list !")));
                        CreateNewHomeWorkBody().build(context);
                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
