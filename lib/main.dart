import 'package:ecommerce_app/Screens/main_menu.dart';
import 'package:ecommerce_app/Screens/search.dart';
import 'package:ecommerce_app/Screens/shoppingcart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/SplashScreen.dart';
import 'Screens/categories.dart';
import 'base/app_State.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=>MyAppState(),
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              routes: <String, WidgetBuilder>{
                "/categories": (BuildContext context) => CategoryScreen(),
                "/search": (BuildContext context) => SearchScreen(),
                "/shoppingcart": (BuildContext context) => ShoppingCart(),
              },
            ));
  }
}
