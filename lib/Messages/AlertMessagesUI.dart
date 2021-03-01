import 'package:flutter/material.dart';

class AlertMessageUI extends Widget {
  String message = "";
  IconData icon = null;
  AlertMessageUI(String _message, IconData _icon) {
    this.message = _message;
    this.icon = _icon;
  }
  @override
  Element createElement() {
    return StatelessElement(Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(23)),
      margin: EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            this.icon,
            size: 50,
            color: Colors.white,
          ),
          Text(
            this.message,
            style: TextStyle(color: Colors.white, fontSize: 25),
          )
        ],
      ),
    ));
  }
}
