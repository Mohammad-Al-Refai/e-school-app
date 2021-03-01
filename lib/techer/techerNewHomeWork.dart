import 'package:e_school_project/Messages/AlertMessagesUI.dart';
import 'package:e_school_project/db/db.dart';
import 'package:e_school_project/techer/questionsWidget.dart';
import 'package:e_school_project/techer/techerCreateNewQ.dart';
import 'package:flutter/material.dart';
import 'package:e_school_project/strings/arbic.dart';
import 'package:provider/provider.dart';
import 'package:e_school_project/stateMangement/Sates.dart';

class CreateNewHomeWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => QPageController(), child: CreateNewHomeWorkBody());
  }
}

class CreateNewHomeWorkBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QPageController>(context);
    DataBaseConnection db = DataBaseConnection();
    db.CreateDataBase();
    Future<bool> refresh() {
      state.getAllData();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text("Updated")));
      return Future.delayed(Duration(seconds: 1));
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CreateNewQ()));
          },
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    state.getAllDataForPost();
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   "${state.marks}:$techerNewHomeWorkNewChooseQMarks",
              //   style: TextStyle(fontSize: 15),
              // ),
              Text("Questions :${state.qdata.length} ",
                  style: TextStyle(fontSize: 15))
            ],
          ),
        ),
        body: Consumer<QPageController>(builder: (dat, state, t) {
          return Container(
            child: Container(
              // height: MediaQuery.of(context).size.height * .8 - 1.600,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: state.title),
                              onChanged: (value) {
                                state.title = value;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Title"),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller:
                                  TextEditingController(text: state.endMark),
                              onChanged: (value) {
                                state.endMark = value;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Mark"),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                        title: new Text("Edit"),
                                        content: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .7,
                                                  child: TextField(
                                                    onChanged: (v) {
                                                      state.title_ = v;
                                                    },
                                                    controller:
                                                        TextEditingController(
                                                            text: state.title),
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: "Title"),
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .7,
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (v) {
                                                      state.endMark_ = v;
                                                    },
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                state.endMark),
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: "Mark"),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Save'),
                                            onPressed: () {
                                              state.u();
                                              state.updateValues();
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            },
                          )
                        ],
                      )),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView(
                          children: state.qdata.length == 0
                              ? [
                                  AlertMessageUI(
                                      "No Questions", Icons.hourglass_empty)
                                ]
                              : state.qdata
                                  .map((e) => QWidget(
                                          context,
                                          e.id,
                                          e.text,
                                          e.options,
                                          e.currectAnswer,
                                          e.mark, (data) {
                                        // state.editQ(e.id, data);
                                      }, (id) {
                                        // state.deleteQ(id);
                                      }))
                                  .toList()),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
