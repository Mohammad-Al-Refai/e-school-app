import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Connecter {
  String URL = "https://e-school-server.herokuapp.com/api/";
  final Connectivity _connectivity = Connectivity();
  teacherLogin(String email, String passwrd, timeout, result) async {
    _connectivity.checkConnectivity().then((value) async {
      if (value.index == 2) {
        result([false]);
      } else {
        var body = jsonEncode({"email": email, "password": passwrd});
        try {
          http.Response response = await http
              .post(URL + "tech/login",
                  headers: {"content-type": "application/json"}, body: body)
              .timeout(Duration(seconds: 10));

          var data = response.body;
          result([true, data]);
        } on TimeoutException catch (e) {
          timeout(e);
        } catch (e) {
          timeout(e);
          return null;
        }
      }
    });
  }

  teacherRegister(
      String name, String email, String passwrd, timeout, result) async {
    _connectivity.checkConnectivity().then((value) async {
      if (value.index == 2) {
        result([false]);
      } else {
        var body =
            jsonEncode({"name": name, "email": email, "password": passwrd});
        try {
          http.Response response = await http
              .post(URL + "tech/register",
                  headers: {"content-type": "application/json"}, body: body)
              .timeout(Duration(seconds: 10));

          var data = response.body;
          result([true, data]);
        } on TimeoutException catch (e) {
          timeout(e);
        } catch (e) {
          timeout(e);
          return null;
        }
      }
    });
  }

  studentRegister(
      String name, String email, String passwrd, timeout, result) async {
    _connectivity.checkConnectivity().then((value) async {
      if (value.index == 2) {
        result([false]);
      } else {
        var body =
            jsonEncode({"name": name, "email": email, "password": passwrd});

        getToken().then((token) async {
          try {
            http.Response response = await http
                .post(URL + "tech/add/student",
                    headers: {
                      "content-type": "application/json",
                      "Authorization": "Bearar $token"
                    },
                    body: body)
                .timeout(Duration(seconds: 10));

            var data = response.body;
            result([true, data]);
          } on TimeoutException catch (e) {
            timeout(e);
          } catch (e) {
            timeout(e);
            return null;
          }
        });
      }
    });
  }

  getStudents(timeout, result) async {
    _connectivity.checkConnectivity().then((value) async {
      if (value.index == 2) {
        result([false]);
      } else {
        getToken().then((token) async {
          try {
            http.Response response = await http
                .get(URL + "tech/get-all/students", headers: {
              "content-type": "application/json",
              "Authorization": "Bearar $token"
            }).timeout(Duration(seconds: 10));

            var data = response.body;
            result([true, data]);
          } on TimeoutException catch (e) {
            timeout(e);
          } catch (e) {
            timeout(e);
            return null;
          }
        });
      }
    });
  }

  setToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  setUserType(type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("type", type);
  }

  setUserState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("state", state);
  }

  Future<bool> getStateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("state");
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("token");
  }

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get("type");
  }
}
