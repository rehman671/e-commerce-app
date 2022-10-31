import 'dart:convert';

import 'package:ecommerce_app/Screens/congrats.dart';
import 'package:ecommerce_app/models/order_response.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../Utils/Utils.dart';
import '../base/app_State.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController nameCTRL = TextEditingController();
  TextEditingController emailCTRL = TextEditingController();
  TextEditingController numCTRL = TextEditingController();
  TextEditingController addCTRL = TextEditingController();
  TextEditingController cityCTRL = TextEditingController();
  TextEditingController zipCTRL = TextEditingController();
  TextEditingController countryCTRL = TextEditingController();

   postTask() async {
     showDialog(context: context, builder: (_)=>const Center(child: SpinKitFadingCircle(
       color: Colors.green,
     )));
    try {
      var body = {
        "name":nameCTRL.text,
        "email": emailCTRL.text,
        "phoneNumber":numCTRL.text,
        "address": addCTRL.text,
        "zip": zipCTRL.text,
        "city": cityCTRL.text,
        "country": countryCTRL.text,
        "items": MyAppState.of(context)?.inCart
      };

      http.Response response = await http.post(Uri.parse("http://ishaqhassan.com:2000/order"),

          headers: <String, String>{
            'Authorization': 'Bearer ${MyAppState.of(context)?.myUser?.logindata?.accessToken}',
            "Content-Type" : "application/json"
          },
          body: jsonEncode(body));
      var bodyresponse = response.body;
      MyAppState.of(context,listen: false)?.myorder = OrderResponse.fromJson(jsonDecode(bodyresponse));
    } catch (e) {
      print("My error ${e.toString()}");
    }
    Navigator.of(context).pop();
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
            child:const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            )),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          )),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Builder(builder: (context) {
            return Column(
              children: [
                const SizedBox(
                  height: 37,
                ),
                form(
                  hinttext: 'Name',
                  textcontroller: nameCTRL,
                  img: 'app_img/checkout_name.jpg',
                ),
                form(
                  hinttext: 'Email address',
                  textcontroller: emailCTRL,
                  img: 'app_img/Vectoremail.jpg',
                ),
                form(
                  hinttext: 'Phone number',
                  textcontroller: numCTRL,
                  img: 'app_img/phone.jpg',
                ),
                form(
                  hinttext: 'Address',
                  textcontroller: addCTRL,
                  img: 'app_img/address.jpg',
                ),
                form(
                  hinttext: 'Zip code',
                  textcontroller: zipCTRL,
                  img: 'app_img/zipcode.jpg',
                ),
                form(
                  hinttext: 'City',
                  textcontroller: cityCTRL,
                  img: 'app_img/city.jpg',
                ),
                form(
                  hinttext: 'Country',
                  textcontroller: countryCTRL,
                  img: 'app_img/country.jpg',
                ),
                const SizedBox(
                  height: 190,
                ),
                GestureDetector(
                  onTap: () async {
                    if (Form.of(context)?.validate() ?? false) {
                      await postTask();
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const CongratsScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('No field can be empty')));
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 17),
                      child: CustomBTN(name: "Next")),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
