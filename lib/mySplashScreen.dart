import 'package:e_school_project/main.dart';
import 'package:e_school_project/techer/techerHomePage.dart';
import 'package:e_school_project/welcomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:e_school_project/net/ServerConnecter.dart';
import 'package:provider/provider.dart';
import 'student/StudentHomePage.dart';

class SplashPage extends StatelessWidget {
  Connecter connecter = Connecter();
  StatelessWidget target = WelcomPage();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashController(),
      child: MaterialApp(
        home: Consumer<SplashController>(
          builder: (l, state, w) {
            connecter.getToken().then((token) {
              print(token);
              if (token == "") {
                connecter.setUserState(false);
              } else {
                connecter.getUserType().then((type) {
                  if (type == "teacher") {
                    state.updateTarget(TecherHome());
                  } else if (type == "student") {
                    state.updateTarget(StudentHome());
                  }
                });
              }
            });
            return SplashScreen(
                seconds: 5,
                navigateAfterSeconds: state.target,
                title: new Text('E-school', style: TextStyle(fontSize: 30)),
                loadingText: Text("Demo"),
                styleTextUnderTheLoader: new TextStyle(),
                photoSize: 100.0);
          },
        ),
        theme: ThemeData(
          fontFamily: "Raleway",
        ),
      ),
    );
  }
}

class SplashController extends ChangeNotifier {
  StatelessWidget target = WelcomPage();
  updateTarget(StatelessWidget _target) {
    target = _target;
    notifyListeners();
  }
}
