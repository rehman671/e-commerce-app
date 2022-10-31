import 'dart:convert';
import 'package:ecommerce_app/Screens/signup.dart';
import 'package:ecommerce_app/base/app_State.dart';
import 'package:ecommerce_app/models/user_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../Network/api_call.dart';
import '../Utils/Utils.dart';
import 'main_menu.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailaddressCTRL = TextEditingController();
  TextEditingController passwordCTRL = TextEditingController();
  bool hidpass = true;
  bool toggle = false;
  loginuser() async {
    showDialog(
        context: context,
        builder: (_) => const Center(
                child: SpinKitFadingCircle(
              color: Colors.green,
            )));
    var url = "http://ishaqhassan.com:2000/user/signin";
    var uri = Uri.parse(url);
    try {
      var response = await http.post(uri, body: {
        "email": emailaddressCTRL.text,
        "password": passwordCTRL.text
      });
      Navigator.of(context).pop();
      var decodedjson = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        MyAppState.of(context, listen: false)!.myUser =
            Userlogin.fromJson(decodedjson);
      });
      if (emailaddressCTRL.text.isNotEmpty || passwordCTRL.text.isNotEmpty) {
        MyAppState.of(context, listen: false)?.SavingIn(response.body, true);
      }
    } catch (e) {
      if (kDebugMode) {
        print("my error $e");
      }
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
                textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ))),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
              "app_img/login.jpg",
              height: 537,
              alignment: const Alignment(-0.3, 0),
              width: 806,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 469),
              decoration: const BoxDecoration(
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
                          margin: const EdgeInsets.only(top: 30, left: 16),
                          child: Text("Welcome back!",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              )))),
                      Container(
                        margin: const EdgeInsets.only(top: 2, left: 16),
                        child: Text("Sign in to your account",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              color: Color(0xff868889),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ))),
                      ),
                      Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          margin: const EdgeInsets.only(top: 26, left: 17),
                          child: Row(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 28),
                                child: Image.asset(
                                  "app_img/Vectoremail.jpg",
                                  width: 23,
                                  height: 17.52,
                                )),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 21),
                                child: TextFormField(
                                  controller: emailaddressCTRL,
                                  validator: (value) {
                                    int status = MyAppState.of(context,listen:false)
                                            ?.myUser
                                            ?.statusCode ??
                                        404;
                                    if (status != 200) {
                                      return "Please Enter correct email or password";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Email Address",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF868889),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ))),
                                ),
                              ),
                            ),
                          ])),
                      Container(
                          width: 380,
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(5)),
                          margin: const EdgeInsets.only(top: 5, left: 17),
                          child: Row(children: [
                            Container(
                                margin: const EdgeInsets.only(left: 28),
                                child: Image.asset(
                                  "app_img/password.jpg",
                                  width: 17.25,
                                  height: 23,
                                )),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 21),
                                child: TextFormField(
                                  validator: (value) {
                                    String Notnullvalue = value ?? "";
                                    if (Notnullvalue.isEmpty) {
                                      return "Please Enter password";
                                    }
                                  },
                                  controller: passwordCTRL,
                                  obscureText: hidpass,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                        color: Color(0xFF868889),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ))),
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 21.12),
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
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 27, top: 25),
                              width: 41,
                              height: 22,
                              child: Switch.adaptive(
                                value: toggle,
                                onChanged: (toggle) {
                                  setState(() {
                                    if (toggle) {
                                      toggle = false;
                                    } else {
                                      toggle = true;
                                    }
                                  });
                                },
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: const Color(0xFFD4D2D2),
                                activeTrackColor: const Color(0xFF4E8E41),
                                activeColor: const Color.fromARGB(0, 0, 0, 0),
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 21, left: 8.43),
                            child: Text("Remember Me",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Color(0xff868889),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ))),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 21, left: 55),
                              // padding: EdgeInsets.only(right: 26),
                              child: Text("Forget password",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                    color: Color(0xff407EC7),
                                    letterSpacing: 0.03,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ))),
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          await loginuser();
                          await callcategories(context);
                          await callproduct(context);

                          if (Form.of(context)?.validate() ?? false) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MainMenu()));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 17, top: 17),
                          child: CustomBTN(
                            name: "Login",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 74, top: 20),
                        child: Row(
                          children: [
                            Text("Don’t have an account ? ",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: Color(0xFF868889),
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ))),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Signup()));
                              },
                              child: Text("Sign up",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
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
