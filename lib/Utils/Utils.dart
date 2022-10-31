import 'dart:io';
import 'package:ecommerce_app/base/app_State.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product.dart';

class CustomBTN extends StatelessWidget {
  String name = "Button";

  CustomBTN({Key? key, required this.name}) : super(key: key);

  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 60,
      decoration: (!ispressed)
          ? BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF6cc51d), Color(0xFFAEDC81)]),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(108, 197, 29, 0.25),
                      blurRadius: 9,
                      offset: Offset(0, 10))
                ])
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.green, Colors.lightGreen]),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(108, 197, 29, 0.25),
                      blurRadius: 9,
                      offset: Offset(0, 10))
                ]),
      child: Center(
          child: Text(name,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 0.03,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )))),
    );
  }
}

updatetoproduct(context) {
  int counter = MyAppState.of(context)?.AllProduct?.product?.length ?? 0;
  int counter_b =
      MyAppState.of(context)?.ProductbyTitle?.product?.length ?? 0;
  for (int b = 0; b <= counter_b - 1; b++) {

    for (int a = 0; a <= counter - 1; a++) {


      if (MyAppState.of(context)?.AllProduct?.product?[a].title ==
          MyAppState.of(context)?.ProductbyTitle?.product?[b].title) {

        MyAppState.of(context)?.AllProduct?.product?[a] =
            MyAppState.of(context)?.ProductbyTitle?.product?[b] ??
                Product();
        break;
      }
    }
  }
}

bool back = false;
int time = 0;
int duration = 1000;
Future<bool> willPop(context) async {
  int now = DateTime.now().millisecondsSinceEpoch;
  if (back && time >= now) {
    back = false;
    exit(0);
  } else {
    time = DateTime.now().millisecondsSinceEpoch + duration;
    back = true;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey,
        content: Text(
          "Press again to Exit",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 10),
        )));
  }
  return false;
}

class form extends StatelessWidget {
  String hinttext = "Hint";
  String img = "app_img/checkout_name.jpg";
  TextEditingController textcontroller = TextEditingController();

  form(
      {Key? key,
      required this.hinttext,
      required this.textcontroller,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 360,
      margin: EdgeInsets.only(left: 17, top: 5),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 17),
            width: 24,
            height: 24,
            child: Image.asset(img),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 21, top: 15,bottom: 13),
              child: TextFormField(
                validator: (value){
                  String myvalue = value ?? "";
                  if(myvalue.isEmpty){
                    return "Field can't be empty";
                  }else{
                    return null;
                  }
                },
                controller: textcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 5,right: 5),
                    hintText: hinttext,

                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF868889),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Product onOpen(Product? a, context) {
  int counter = MyAppState.of(context)?.AllProduct?.product?.length ?? 0;
  for (int index = 0; index < counter; index++) {
    if (MyAppState.of(context)?.AllProduct?.product?[index].title ==
        a?.title) {
      return MyAppState.of(context)!.AllProduct!.product![index];
    }
  }
  return Product();
}

void onBack(List<Product>? a, context) async {
  int counter = MyAppState.of(context)?.AllProduct?.product?.length ?? 0;
  int my_counter = a?.length ?? 0;
  for (int index = 0; index < counter; index++) {
    for (int my_index = 0; my_index < my_counter; my_index++) {
      if (MyAppState.of(context)?.AllProduct?.product?[index].title ==
          a?[my_index].title) {
        a![my_index] =
            MyAppState.of(context)!.AllProduct!.product![index];
        break;
      }
    }
  }
}
