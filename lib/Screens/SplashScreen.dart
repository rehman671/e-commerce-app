import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_app/Screens/main_menu.dart';
import 'package:ecommerce_app/base/app_State.dart';
import 'package:ecommerce_app/models/user_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Network/api_call.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigateto);
  }

  void navigateto() async {
    final prefs = await SharedPreferences.getInstance();

    MyAppState.of(context,listen: false)?.UserIn = prefs.getBool("LOGGED") ?? false;
    if (MyAppState.of(context,listen: false)?.UserIn != true) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => Login()), (route) => false);
    } else {
      setState(() {
        MyAppState.of(context,listen: false)?.myUser = Userlogin.fromJson(
            jsonDecode(prefs.getString('json')?? "") as Map<String, dynamic>);
      });

      await callcategories(context);
      await callproduct(context);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => MainMenu()), (route) => false);
    }
  }

  @override
  initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.loose, children: [
      Positioned(
        width: 655,
        height: 984,
        left: -201,
        child: Image.asset(
          "app_img/sp_bg.jpg",
          fit: BoxFit.fill,
        ),
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 96),
            child: Center(
              child: Text(
                "Welcome to",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            width: 127,
            height: 50,
            child: Image.asset("app_img/bigCart_1.png"),
          ),
          Container(
            child: Text(
              "Lorem ipsum dolor sit amet, consetetur \n sadipscing elitr, sed diam nonumy",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0XFF868889),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )),
            ),
          ),
          SizedBox(
            height: 557,
          ),
          Container(
            child: Text(
              "DEVELOPED BY",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Color(0XFF868889),
                fontWeight: FontWeight.w500,
                letterSpacing: 5,
                fontSize: 15,
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text("ABDUL REHMAN",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Color(0XFF6CC51D),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 7,
                  fontSize: 20,
                ))),
          )
        ],
      ),
    ]));
  }
}
