import 'package:ecommerce_app/base/app_State.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/Utils.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    int? myIndex;
    if (MyAppState.of(context)!.ProductbyID!.product!.isNotEmpty) {
      myIndex = MyAppState.of(context)!.ProductbyID!.product![0].catId!;
      myIndex = ((myIndex ?? 0 )- 1);
    }

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
        title: (myIndex != null)
            ? Text(
                MyAppState.of(context)
                        ?.AllCategories
                        ?.category![myIndex]
                        .title ??
                    "",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                )),
              )
            : Text(
                "Data Not Available",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                )),
              ),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 17.4),
              child: Icon(
                Icons.tune_sharp,
                color: Colors.black,
              ))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          onBack(MyAppState.of(context)?.ProductbyID?.product, context);
          return true;
        },
        child: Container(
            child: (MyAppState.of(context)!
                    .ProductbyID!
                    .product!
                    .isNotEmpty)
                ? GridView.builder(
                    itemCount: MyAppState.of(context)
                        ?.ProductbyID
                        ?.product
                        ?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                        if (onOpen(
                                                    MyAppState.of(
                                                            context)
                                                        ?.ProductbyID
                                                        ?.product?[index],
                                                    context)
                                                .favproduct ==
                                            2) {
                                          onOpen(
                                                  MyAppState.of(context)
                                                      ?.ProductbyID
                                                      ?.product?[index],
                                                  context)
                                              .favproduct = 1;
                                        } else {
                                          onOpen(
                                                  MyAppState.of(context)
                                                      ?.ProductbyID
                                                      ?.product?[index],
                                                  context)
                                              .favproduct = 2;
                                        }
                                        ;
                                      });
                                    },
                                    child: Container(
                                        height: 21,
                                        child: (onOpen(
                                                        MyAppState.of(
                                                                context)
                                                            ?.ProductbyID
                                                            ?.product?[index],
                                                        context)
                                                    .favproduct ==
                                                2)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(Icons
                                                .favorite_border_outlined)))
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
                                      color: MyAppState.of(context)
                                          ?.productcolor[index],
                                      shape: BoxShape.circle),
                                ),
                              ),
                              Container(
                                height: 84,
                                margin: EdgeInsets.only(
                                    left: 42, right: 48, top: 22),
                                child: Image.network(onOpen(
                                            MyAppState.of(context)
                                                ?.ProductbyID
                                                ?.product?[index],
                                            context)
                                        .image ??
                                    ""),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                                "\$ ${MyAppState.of(context)?.ProductbyID?.product?[index].price.toString() ?? "Loading"}",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  color: Color(0xFF6CC51D),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ))),
                          ),
                          Container(
                            child: Text(
                                MyAppState.of(context)
                                        ?.ProductbyID
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
                                MyAppState.of(context)
                                        ?.ProductbyID
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
                          if (onOpen(
                                      MyAppState.of(context)
                                          ?.ProductbyID!
                                          .product![index],
                                      context)
                                  .qty ==
                              null)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  onOpen(
                                          MyAppState.of(context)
                                              ?.ProductbyID!
                                              .product![index],
                                          context)
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
                          if (onOpen(
                                      MyAppState.of(context)
                                          ?.ProductbyID!
                                          .product![index],
                                      context)
                                  .qty !=
                              null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (onOpen(
                                                  MyAppState.of(context)
                                                      ?.ProductbyID!
                                                      .product![index],
                                                  context)
                                              .qty! >
                                          1) {
                                        onOpen(
                                                MyAppState.of(context)
                                                    ?.ProductbyID!
                                                    .product![index],
                                                context)
                                            .qty = onOpen(
                                                    MyAppState.of(
                                                            context)
                                                        ?.ProductbyID!
                                                        .product![index],
                                                    context)
                                                .qty! -
                                            1;
                                      } else {
                                        onOpen(
                                                MyAppState.of(context)
                                                    ?.ProductbyID!
                                                    .product![index],
                                                context)
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
                                      "${onOpen(MyAppState.of(context)?.ProductbyID?.product?[index], context).qty}",
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
                                      onOpen(
                                              MyAppState.of(context)
                                                  ?.ProductbyID!
                                                  .product![index],
                                              context)
                                          .qty = (onOpen(
                                                  MyAppState.of(context)
                                                      ?.ProductbyID!
                                                      .product![index],
                                                  context)
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
                                          color: Color(0xFF6CC51D),
                                          fontSize: 15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]
                        ])))
                : Center(
                    child: Text("Nothing Found",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ))),
                  )),
      ),
    );
  }
}
