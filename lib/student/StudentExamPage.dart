import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StudentExamPage extends StatelessWidget {
  String id;
  String title = "";
  StudentExamPage(String _id, String _title) {
    this.id = _id;
    this.title = _title;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}


// LoadData(){

  //?data like this
//   Map data = {
//     "title": "ssghshsjs",
//     "endMark": "hxhxjsdxd",
//     "questions": [
//       {
//         "mark": 15,
//         "text": "hsjzhzgs",
//         "options": ["sjnsndbs", "hsjsns", "shsnsjs"],
//         "currect": "C"
//       },
//       {
//         "mark": 518,
//         "text": "hshzbzvsx",
//         "options": ["hshsn", "bshsa", "janabs"],
//         "currect": "C"
//       },
//       {
//         "mark": 61,
//         "text": "gsgbs",
//         "options": ["bzvscs", "hsvsxs", "gsvsbs"],
//         "currect": "C"
//       }
//     ]
//   };

//   return {"title":data["title"],"endMark":data["endMark"],}

// }