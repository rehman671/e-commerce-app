import 'package:ecommerce_app/models/categories_response.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/user_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_response.dart';
import '../models/order_response.dart';
import '../models/order_response.dart';

class MyAppState extends ChangeNotifier {
  List<Color> categorycolor = const [
    Color(0xFFE6F2EA),
    Color(0xFFFFE9E5),
    Color(0xFFFFF6E3),
    Color(0xFFFFE8F2),
    Color(0xFFDCF4F5),
    Color(0xFFF3EFFA),
  ];

  List<Color> productcolor = [
    Color(0xFFFFCEC1),
    Color(0xFFFCFFD9),
    Color(0xFFFFE6C2),
    Color(0xFFFEE1ED),
    Color(0xFFFFE3E2),
    Color(0xFFD2FFD0),
  ];
  Userlogin? myUser;
  List<Product> inCart = [];
  AllCategoriesResponse? AllCategories;
  AllProductResponse? ProductbyID;
  AllProductResponse? ProductbyTitle;
  AllProductResponse? AllProduct;
  String? search;
  OrderResponse? myorder;
  bool UserIn = false;

  SavingIn(String? json, bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("json", json!);
    await prefs.setBool("LOGGED", loggedIn);
  }

  static of(BuildContext context,{bool listen  = false}) => Provider.of<MyAppState>(context,listen:listen);
}