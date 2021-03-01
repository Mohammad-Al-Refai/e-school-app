import 'package:e_school_project/db/db.dart';
import 'package:e_school_project/stateMangement/Sates.dart';
import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/techer/questionsWidget.dart';
import 'package:e_school_project/techer/techerNewHomeWork.dart';
import 'package:e_school_project/validation/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditQ extends StatelessWidget {
  String id;
  bool x = false;
  EditQ(String _id) {
    this.id = _id;
  }
  @override
  Widget build(BuildContext context) {
    DataBaseConnection db = DataBaseConnection();
    return ChangeNotifierProvider(
      create: (_) => QEditController(context),
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateNewHomeWork()));
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Edit Q"),
          ),
          body: Center(
            child: Consumer<QEditController>(builder: (x, state, d) {
              if (!(this.x)) {
                state.getData(id);
                this.x = true;
              }
              Validation validation = Validation();
              return SingleChildScrollView(
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
                            controller: TextEditingController(text: state.mark),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              state.mark = value;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none, labelText: "Mark"),
                          ),
                          TextField(
                            controller: TextEditingController(text: state.text),
                            onChanged: (value) {
                              state.text = value;
                            },
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: "...",
                                border: InputBorder.none,
                                labelText: "Text"),
                          ),
                          Container(
                            height: 201,
                            child: Column(
                              children: [
                                ListTile(
                                    title: TextField(
                                      controller:
                                          TextEditingController(text: state.o1),
                                      onChanged: (value) {
                                        state.o1 = value;
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
                                        controller: TextEditingController(
                                            text: state.o2),
                                        onChanged: (value) {
                                          state.o2 = value;
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
                                      controller:
                                          TextEditingController(text: state.o3),
                                      onChanged: (value) {
                                        state.o3 = value;
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
                                  value: state.currect,
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
                                    state.currect = value;
                                  }))
                        ],
                      )),
                  Consumer<QEditController>(
                    builder: (BuildContext context, value, Widget child) {
                      return FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            List<String> res = validation.check([
                              state.mark,
                              state.text,
                              state.o1,
                              state.o2,
                              state.o3,
                              state.currect
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(res[0])));
                            } else {
                              db.updateQuestion(
                                  int.parse(this.id),
                                  state.mark,
                                  state.text,
                                  state.o1,
                                  state.o2,
                                  state.o3,
                                  state.currect);

                              // value.update();
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CreateNewHomeWork()));
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ));
                    },
                  ),
                ],
              ));
            }),
          ),
        ),
      ),
    );
  }
}

class QEditController extends ChangeNotifier {
  BuildContext context;
  String id = "";
  String text = "";
  String mark = "";
  String o1 = "";
  String o2 = "";
  String o3 = "";
  String currect = "A";
  DataBaseConnection db = DataBaseConnection();
  QEditController(BuildContext _context) {
    this.context = _context;
  }

  getData(id) {
    db.getOne(int.parse(id)).then((value) {
      print(value);
      this.currect = value[0]["currect"].toString();
      this.mark = value[0]["mark"];
      this.o1 = value[0]["o1"];
      this.o2 = value[0]["o2"];
      this.o3 = value[0]["o3"];
      this.text = value[0]["text"];
      notifyListeners();
    });
  }

  update() {
    var x = context.watch<QPageController>();
    x.qdata = [];
    x.getAllData();
  }
}
