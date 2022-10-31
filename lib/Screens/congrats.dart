import 'package:ecommerce_app/Utils/Utils.dart';
import 'package:ecommerce_app/base/app_State.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_menu.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 227,
              height: 194,
              margin: EdgeInsets.only(top: 186, left: 87),
              child: Image.asset("app_img/congrats.jpg")),
          Container(
              margin: EdgeInsets.only(top: 45, left: 141),
              child: Text(
                "Congrats!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color(0xFF282828)),
              )),
          Container(
              margin: EdgeInsets.only(top: 8, left: 86),
              width: 232,
              height: 49,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Your Order ",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFFB1B1B1),
                        )),
                    TextSpan(
                        text:
                            "#${MyAppState.of(context,listen:false)?.myorder?.order?.id} ",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFFB1B1B1))),
                    TextSpan(
                        text: "is\nSuccessfully Received",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFFB1B1B1)))
                  ]))),
          Container(
            margin: EdgeInsets.only(top: 286,left: 17),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>MainMenu()));
              },
                child: CustomBTN(name: "Go to home")),
          )
        ],
      ),
    );
  }
}
