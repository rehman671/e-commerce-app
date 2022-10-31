import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../base/app_State.dart';
import '../models/categories_response.dart';
import '../models/product.dart';

// CALL PRODUCT BY TITLE
callproductbytitle(String a,BuildContext context) async {
  showDialog(context: context, builder: (_)=>const Center(child: SpinKitFadingCircle(
    color: Colors.green,
  )));
  String url = "http://ishaqhassan.com:2000/product/search?q=$a";
  try {
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization":
      "Bearer ${MyAppState.of(context,listen:false)?.myUser?.logindata?.accessToken}"
    });
    var decodedjson = jsonDecode(response.body);
    MyAppState.of(context,listen: false)?.ProductbyTitle =
        AllProductResponse.fromJson(decodedjson);
  } catch (e) {
    print("My Error : $e");
  }
  Navigator.of(context).pop();
}

// CALL PRODUCT BY ID
callproductbyID(int? a,BuildContext context) async {
  String url = "http://ishaqhassan.com:2000/product/$a";
  try {
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization":
      "Bearer ${MyAppState.of(context,listen:false)?.myUser?.logindata?.accessToken}"
    });
    var decodedjson = jsonDecode(response.body);
    MyAppState.of(context,listen: false)?.ProductbyID =
        AllProductResponse.fromJson(decodedjson);
  } catch (e) {
    print("My Error : $e");
  }
}

callcategories(BuildContext context) async {
  String url = "http://ishaqhassan.com:2000/category";
  try {
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization":
      "Bearer ${MyAppState.of(context,listen:false)?.myUser?.logindata?.accessToken}"
    });
    var decodedjson = jsonDecode(response.body);
    MyAppState.of(context,listen: false)!.AllCategories =
        AllCategoriesResponse.fromJson(decodedjson);
  } catch (e) {
    print("My Error : $e");
  }
}



callproduct(context) async {
  String url = "http://ishaqhassan.com:2000/product";
  try {
    var response = await http.get(Uri.parse(url), headers: {
      "Authorization":
      "Bearer ${MyAppState.of(context,listen:false)?.myUser?.logindata?.accessToken}"
    });
    var decodedjson = jsonDecode(response.body);
    MyAppState.of(context,listen: false)!.AllProduct =
        AllProductResponse.fromJson(decodedjson);
  } catch (e) {
    print("My Error : $e");
  }
}

