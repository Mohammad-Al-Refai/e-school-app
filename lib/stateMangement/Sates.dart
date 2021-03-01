import 'package:e_school_project/db/db.dart';
import 'package:e_school_project/techer/questionsWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QPageController extends ChangeNotifier {
  String title = "";
  String endMark = "";
  String title_ = "";
  String endMark_ = "";
  int count = 0;
  int marks = 0;
  List<QData> qdata = [];

  Map response = {"title": "", "endMark": "", "questions": []};
  QPageController() {
    qdata = [];

    DataBaseConnection db = DataBaseConnection();
    db.insertDetails(this.title, this.endMark);
    db.getOnefromDetails(1).then((v) {
      this.title = v[0]["title"];
      this.endMark = v[0]["endMark"];
    });
    Future<dynamic> data = db.getAll();
    data.then((values) {
      values.forEach((value) => qdata.add(QData(
            value["id"].toString(),
            value["text"],
            [
              value["o1"],
              value["o2"],
              value["o3"],
            ],
            value["currect"],
            value["mark"],
          )));

      notifyListeners();
    });
  }

  getAllData() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // this.title = prefs.getString("title");
    // this.endMark = prefs.getString("endMark");
    qdata = [];
    DataBaseConnection db = DataBaseConnection();
    db.insertDetails(this.title, this.endMark);
    db.getOnefromDetails(1).then((v) {
      this.title = v[0]["title"];
      this.endMark = v[0]["endMark"];
    });

    Future<dynamic> data = db.getAll();
    data.then((values) {
      values.forEach((value) => qdata.add(QData(
            value["id"].toString(),
            value["text"],
            [
              value["o1"],
              value["o2"],
              value["o3"],
            ],
            value["currect"],
            value["mark"],
          )));

      notifyListeners();
    });
  }

  updateValues() {
    DataBaseConnection db = DataBaseConnection();
    db.updateDetails(1, title, endMark);
    notifyListeners();
  }

  u() {
    if (!(title_ == "")) {
      this.title = title_;
    }
    if (!(this.endMark_ == "")) {
      this.endMark = endMark_;
    }

    notifyListeners();
  }

  getAllDataForPost() {
    response["title"] = title;
    response["endMark"] = endMark;
    qdata.forEach((e) {
      response["questions"].add({
        "mark": e.mark,
        "text": e.text,
        "options": e.options,
        "currect": e.currectAnswer
      });
    });
    print(response);
  }
}
