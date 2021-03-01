import 'package:e_school_project/db/db.dart';
import 'package:e_school_project/stateMangement/Sates.dart';
import 'package:e_school_project/strings/arbic.dart';
import 'package:e_school_project/techer/techerEditQ.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QData {
  String id;
  String text;
  String mark;
  List<String> options;
  String currectAnswer;
  QData(String _id, String _text, List<String> _options, String _currectAnswer,
      String _mark) {
    this.text = _text;
    this.options = _options;
    this.currectAnswer = _currectAnswer;
    this.mark = _mark;
    this.id = _id;
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'options': options,
      'mark': mark,
      'currectAnswer': currectAnswer,
    };
  }

  // edit(String text_, List<String> options_, String currectAnswer_, int mark_) {
  //   this.text = text_;
  //   this.options = options_;
  //   this.currectAnswer = currectAnswer_;
  //   this.mark = mark_;
  // }
}

class QWidget extends Widget {
  String id;
  Function callback;
  Function remove;
  List<dynamic> data;
  BuildContext context;
  String text;
  String mark;
  List<String> options;
  String currectAnswer;
  QWidget(
      BuildContext _context,
      String _id,
      String _text,
      List<String> _options,
      String _currectAnswer,
      String _mark,
      Function _callback,
      Function _remove) {
    this.text = _text;
    this.options = _options;
    this.currectAnswer = _currectAnswer;
    this.mark = _mark;
    this.context = _context;
    this.id = _id;
    this.callback = _callback;
    this.data = [
      this.mark,
      this.text,
      [
        [this.options[0]],
        [this.options[1]],
        [this.options[2]]
      ],
      this.currectAnswer
    ];
    this.remove = _remove;
  }
  @override
  Element createElement() {
    return StatelessElement(Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                this.mark = (value == "" ? "0" : value);
                data[0] = this.mark;
                callback(data);
              },
              controller: TextEditingController(text: this.mark.toString()),
              readOnly: true,
              decoration:
                  InputDecoration(border: InputBorder.none, labelText: "Mark"),
            ),
            TextField(
              readOnly: true,
              onChanged: (value) {
                this.text = value;
                data[1] = this.text;
                callback(data);
              },
              controller: TextEditingController(text: this.text),
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: "...", border: InputBorder.none, labelText: "Text"),
            ),
            Container(
              height: 205,
              child: Column(
                children: [
                  ListTile(
                      title: TextField(
                        readOnly: true,
                        onChanged: (value) {
                          this.options[0] = value;
                          data[2][0][0] = this.options[0];
                          // print(data[2][0]);
                          callback(data);
                        },
                        controller:
                            TextEditingController(text: this.options[0]),
                        decoration: InputDecoration(
                          labelText: "Option A",
                        ),
                      ),
                      leading: Text(
                        "A -",
                        style: TextStyle(fontSize: 20),
                      )),
                  ListTile(
                      title: TextField(
                          readOnly: true,
                          onChanged: (value) {
                            this.options[1] = value;
                            data[2][1][0] = this.options[1];
                            callback(data);
                          },
                          controller:
                              TextEditingController(text: this.options[1]),
                          decoration: InputDecoration(labelText: "Option B")),
                      leading: Text(
                        "B -",
                        style: TextStyle(fontSize: 20),
                      )),
                  ListTile(
                      title: TextField(
                        readOnly: true,
                        onChanged: (value) {
                          this.options[2] = value;
                          data[2][2][0] = this.options[2];
                          callback(data);
                        },
                        controller:
                            TextEditingController(text: this.options[2]),
                        decoration: InputDecoration(
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
            Container(
                child: TextField(
              readOnly: true,
              controller: TextEditingController(text: this.currectAnswer),
              decoration: InputDecoration(labelText: "Currect Answer"),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                Consumer<QPageController>(
                  builder: (BuildContext context, value, Widget child) {
                    return FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          DataBaseConnection db = DataBaseConnection();
                          db.removeQuestion(int.parse(this.id));
                          value.getAllData();
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(color: Colors.white),
                        ));
                  },
                ),
                FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => EditQ(this.id)));
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        )));
  }
}
