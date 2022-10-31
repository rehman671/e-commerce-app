import 'dart:convert';

import 'package:ecommerce_app/Screens/login.dart';
import 'package:ecommerce_app/Utils/Utils.dart';
import 'package:ecommerce_app/base/app_State.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_login.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  signOut() async {
    var url = "http://ishaqhassan.com:2000/user";
    try {
      var uri = Uri.parse(url);
      var response = await http.post(uri, headers: {
        "Authorization":
            "Bearer ${MyAppState.of(context,listen:false)?.myUser?.logindata?.accessToken}"
      }, body: {
        "email": MyAppState.of(context,listen:false)?.myUser?.logindata?.email,
        "password": MyAppState.of(context,listen:false)?.myUser?.logindata?.password
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
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            )),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          )),
        ),
      ),
      body: Column(
        children: [
          Container(

            decoration: BoxDecoration(
      gradient: LinearGradient(

          begin: Alignment.bottomRight,
          end: Alignment.center,
          colors: [Colors.white10, Color(0xFFAEDC81)]),
              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.only(top: 50,left: 20,right: 20),
            height: 75,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Email",style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                Text(MyAppState.of(context,listen:false)?.myUser?.logindata?.email ?? "",style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                )),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
    gradient: LinearGradient(

        begin: Alignment.bottomRight,
        end: Alignment.center,
    colors: [Colors.white10, Color(0xFFAEDC81)]),              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.only(top: 7,left: 20,right: 20),
            height: 75,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Phone",style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                Text(MyAppState.of(context,listen:false)?.myUser?.logindata?.phone ?? "",style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                )),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.center,
    colors: [Colors.white10, Color(0xFFAEDC81)]),              borderRadius: BorderRadius.circular(20)
            ),
            margin: EdgeInsets.only(top: 7,left: 20,right: 20),
            height: 75,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Password",style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                Text(MyAppState.of(context,listen:false)?.myUser?.logindata?.password ?? "",style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                )),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          GestureDetector(
            onTap: ()async{
              final prefs = await SharedPreferences.getInstance();
             await signOut();
             prefs.setBool("LOGGED",false);
             prefs.remove("json");
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Login()), (route) => false);

            },
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
                child: CustomBTN(name: "logout")),
          )

        ],
      ),
    );
  }
}
