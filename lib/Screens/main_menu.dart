
import 'package:ecommerce_app/Screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_app/base/app_State.dart';

import '../Network/api_call.dart';
import '../Utils/Utils.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  TextEditingController SearchController = TextEditingController();
  int hearticon = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        height: 68.0,
        width: 68.0,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/shoppingcart").then((value) => {setState((){})});
            },
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 25,
            ),
            backgroundColor: Color(0xFF6CC51D),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return willPop(context);
        },
        child: Container(
          width: 1000,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white, Color(0xFFF4F5F9)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(5)),
                width: 380,
                height: 50,
                margin: EdgeInsets.only(top: 51, left: 17),
                child: Row(children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(left: 21),
                    child: Image.asset("app_img/search.png"),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 14, left: 20.25),
                    child: TextFormField(
                      controller: SearchController,
                      onFieldSubmitted: (value) async {
                        await callproductbytitle(value,context);
                        MyAppState.of(context,listen: false)?.search = value;
                        Navigator.pushNamed(context, "/search")
                            .then((value) => {setState(() {})});
                      },
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Search keyword",
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xFF868889),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ))),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(right: 16.05),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingScreen()));
                      },
                      child: Icon(
                        Icons.tune_sharp,
                        color: Color(0xFF868889),
                        size: 25.5,
                      ),
                    ),
                  )
                ]),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 17),
                    width: 380,
                    height: 283,
                    child: Container(
                        height: 327,
                        width: 490,
                        child: Image.asset(
                          "app_img/menu.jpg",
                          fit: BoxFit.fitHeight,
                          alignment: Alignment(0.9, 0),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 161, left: 61),
                    child: Text(
                      "20% off on your \n first purchase",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Categories",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 16.48),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color(0xFF868889),
                        ))
                  ],
                ),
              ),
              Container(
                height: 127,
                margin: EdgeInsets.only(top: 17),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: MyAppState.of(context,listen:false)
                        ?.AllCategories
                        ?.category
                        ?.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await callproductbyID(MyAppState.of(context,listen:false)
                              ?.AllCategories
                              ?.category?[index]
                              .id,context);
                          Navigator.pushNamed(context, '/categories')
                              .then((value) => {setState(() {})});
                        },
                        child: Column(
                          children: [
                            Container(
                                height: 52,
                                width: 52,
                                padding: EdgeInsets.only(top: 13.5, bottom: 13),
                                decoration: BoxDecoration(
                                    color: MyAppState.of(context,listen:false)
                                        ?.categorycolor[index],
                                    shape: BoxShape.circle),
                                margin: EdgeInsets.only(right: 1, left: 20),
                                child: ((index > 3))
                                    ? Center(
                                        child: Text("N/A",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ))))
                                    : Image.network(
                                        MyAppState.of(context,listen:false)
                                                ?.AllCategories
                                                ?.category?[index]
                                                .icon ??
                                            "")),
                            Container(
                              margin: EdgeInsets.only(top: 11, left: 16),
                              child: Text(
                                MyAppState.of(context,listen:false)
                                        ?.AllCategories
                                        ?.category?[index]
                                        .title ??
                                    "Not Available",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Color(0xFF868889),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text("Featured products",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ))),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 16.48),
                      child: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xFF868889),
                      ))
                ],
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 29),
                child: GridView.builder(
                  itemCount: MyAppState.of(context,listen:false)
                      ?.AllProduct
                      ?.product
                      ?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => Container(
                      height: 300,
                      width: 181,
                      color: Colors.white,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(right: 8, top: 9.88),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (MyAppState.of(context,listen:false)
                                              ?.AllProduct
                                              ?.product?[index]
                                              .favproduct ==
                                          2) {
                                        MyAppState.of(context,listen: false)
                                            ?.AllProduct
                                            ?.product?[index]
                                            .favproduct = 1;
                                      } else {
                                        MyAppState.of(context,listen: false)
                                            ?.AllProduct
                                            ?.product?[index]
                                            .favproduct = 2;
                                      }
                                      ;
                                    });
                                  },
                                  child: Container(
                                      height: 21,
                                      child: (MyAppState.of(context,listen:false)
                                                  ?.AllProduct
                                                  ?.product?[index]
                                                  .favproduct ==
                                              2)
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border_outlined)))
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                    color: MyAppState.of(context,listen:false)
                                        ?.productcolor[index],
                                    shape: BoxShape.circle),
                              ),
                            ),
                            Container(
                              height: 84,
                              margin:
                                  EdgeInsets.only(left: 42, right: 48, top: 22),
                              child: Image.network(MyAppState.of(context,listen:false)
                                      ?.AllProduct
                                      ?.product?[index]
                                      .image ??
                                  ""),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                              "\$ ${MyAppState.of(context,listen:false)?.AllProduct?.product?[index].price.toString() ?? "Loading"}",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Color(0xFF6CC51D),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))),
                        ),
                        Container(
                          child: Text(
                              MyAppState.of(context,listen:false)
                                      ?.AllProduct
                                      ?.product?[index]
                                      .title ??
                                  "loading",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ))),
                        ),
                        Container(
                          child: Text(
                              MyAppState.of(context,listen:false)
                                      ?.AllProduct
                                      ?.product?[index]
                                      .unit ??
                                  "loading",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Color(0xFF868889),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))),
                        ),
                        Divider(
                          thickness: 0,
                          color: Color(0xFFEBEBEB),
                        ),
                        if (MyAppState.of(context,listen:false)
                                ?.AllProduct
                                ?.product?[index]
                                .qty ==
                            null)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                MyAppState.of(context,listen: false)
                                    ?.AllProduct
                                    ?.product?[index]
                                    .qty = 1;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Color(0xFF6CC51D),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 9),
                                    child: Text("Add to cart",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          color: Color(0xFF010101),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        )))),
                              ],
                            ),
                          ),
                        if (MyAppState.of(context,listen:false)
                                ?.AllProduct
                                ?.product?[index]
                                .qty !=
                            null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (MyAppState.of(context,listen:false)!
                                            .AllProduct!
                                            .product![index]
                                            .qty! >
                                        1) {
                                      MyAppState.of(context,listen: false)
                                          ?.AllProduct!
                                          .product![index]
                                          .qty = (MyAppState.of(context,listen:false)!
                                              .AllProduct!
                                              .product![index]
                                              .qty! -
                                          1);
                                    } else {
                                      MyAppState.of(context,listen: false)
                                          ?.AllProduct!
                                          .product![index]
                                          .qty = null;
                                    }
                                  });
                                },
                                child: Container(
                                    margin: EdgeInsets.only(left: 19),
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          color: Color(0xFF6CC51D),
                                          fontSize: 20),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 56.48),
                                child: Text(
                                    "${MyAppState.of(context,listen:false)?.AllProduct?.product?[index].qty}",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      color: Color(0xFF010101),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    MyAppState.of(context,listen: false)
                                        ?.AllProduct!
                                        .product![index]
                                        .qty = (MyAppState.of(context,listen:false)!
                                            .AllProduct!
                                            .product![index]
                                            .qty! +
                                        1);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 56.48),
                                  padding: EdgeInsets.all(3),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Color(0xFF6CC51D), fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ])),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
