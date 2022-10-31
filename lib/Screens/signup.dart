import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../Utils/Utils.dart';
import '../base/app_State.dart';
import '../models/user_login.dart';
import '../models/users.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Users? myUser;
  TextEditingController emailaddressCTRL = TextEditingController();
  TextEditingController phoneCTRL = TextEditingController();
  TextEditingController passwordCTRL = TextEditingController();
  bool hidpass = true;
  bool toggle = false;

  signUp() async {
    var url = "http://ishaqhassan.com:2000/user";
    try {
      var uri = Uri.parse(url);
      var response = await http.post(uri, body: {
        "email": emailaddressCTRL.text,
        "phone": phoneCTRL.text,
        "password": passwordCTRL.text
      });
      var decodedjson = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        MyAppState.of(context,listen: false)!.myUser = Userlogin.fromJson(decodedjson);
      });
    } catch (e) {
      print("my error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 131.0,
        backgroundColor: Colors.transparent,
        title: Text("Welcome",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ))),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.black, Colors.transparent])),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "app_img/signup.jpg",
              height: 482,
              alignment: Alignment(0.2, 0),
              width: 722,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 469),
              decoration: BoxDecoration(
                  color: Color(0xFFF4F5F9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: 414,
              height: 453,
              child: Form(
                child: Builder(builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 30, left: 16),
                          child: Text("Create Account",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              )))),
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 16),
                        child: Text("Quickly create account",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Color(0xff868889),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ))),
                      ),
                      Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(top: 26, left: 17),
                          child: Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 28),
                                child: Image.asset(
                                  "app_img/Vectoremail.jpg",
                                  width: 23,
                                  height: 17.52,
                                )),
                            Container(
                              width: 300,
                              margin: EdgeInsets.only(left: 21),
                              child: TextFormField(
                                validator: (value) {
                                  if (MyAppState.of(context,listen:false)
                                          ?.myUser
                                          ?.statusCode !=
                                      200) {
                                    return MyAppState.of(context,listen:false)
                                        ?.myUser
                                        ?.message;
                                  }
                                  return null;
                                },
                                controller: emailaddressCTRL,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Email Address",
                                    hintStyle: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      color: Color(0xFF868889),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ))),
                              ),
                            ),
                          ])),
                      Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(top: 5, left: 17),
                          child: Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 28),
                                child: Image.asset(
                                  "app_img/phone.jpg",
                                  width: 22.91,
                                  height: 23,
                                )),
                            Container(
                              width: 300,
                              margin: EdgeInsets.only(left: 21),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length != 11) {
                                    return "Please enter valid phone number";
                                  }
                                  return null;
                                },
                                controller: phoneCTRL,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: "Phone number",
                                    hintStyle: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      color: Color(0xFF868889),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ))),
                              ),
                            ),
                          ])),
                      Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.only(top: 5, left: 17),
                          child: Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 28),
                                child: Image.asset(
                                  "app_img/password.jpg",
                                  width: 17.25,
                                  height: 23,
                                )),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 21),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return "Password should have 6 characters";
                                    }
                                    return null;
                                  },
                                  controller: passwordCTRL,
                                  obscureText: hidpass,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: Color(0xFF868889),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ))),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 21.12),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (hidpass == true) {
                                        hidpass = false;
                                      } else {
                                        hidpass = true;
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    "app_img/eye.jpg",
                                    width: 26.38,
                                    height: 16.88,
                                  ),
                                ))
                          ])),
                      GestureDetector(
                        onTap: () async {
                          await signUp();
                          if (Form.of(context)?.validate() ?? false) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 17, top: 17),
                          child: CustomBTN(
                            name: "Signup",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 74, top: 15),
                        child: Row(
                          children: [
                            Text("Already have an account ? ",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Color(0xFF868889),
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ))),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => Login()));
                              },
                              child: Text("Login",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 0.03,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ))),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  switchbtn() {}
}
