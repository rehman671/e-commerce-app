import 'package:ecommerce_app/Screens/checkout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/Utils.dart';
import '../base/app_State.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double subtotal = 0;

  //Sum of total amount
  sum() {
    int cart = MyAppState.of(context)?.inCart.length ?? 0;
    for (int a = 0; a < cart; a++) {
      subtotal = subtotal +
          (MyAppState.of(context)!.inCart[a].qty! *
              MyAppState.of(context)!.inCart[a].price!);
    }
  }

  //MANAGING CART
  Cartmanage(context) {
    int counter =
        MyAppState.of(context)?.AllProduct?.product?.length ?? 0;
    for (int a = 0; a < counter; a++) {
      if (MyAppState.of(context)?.AllProduct?.product?[a].qty != null &&
          MyAppState.of(context)?.AllProduct?.product?[a].qty != 0) {
        if (!MyAppState.of(context)!
            .inCart
            .contains(MyAppState.of(context)?.AllProduct?.product?[a])) {
          MyAppState.of(context, listen: false)
              ?.inCart
              .add(MyAppState.of(context)!.AllProduct!.product![a]);
        }
      }
    }
    setState(() {
      subtotal = 0;
      sum();
    });
  }

  @override
  Widget build(BuildContext context) {
    Cartmanage(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              MyAppState.of(context)?.inCart = [];
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
          "Shopping Cart",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          )),
        ),
      ),
      body: (MyAppState.of(context)!.inCart.isNotEmpty)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: MyAppState.of(context)?.inCart.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            alignment: Alignment.centerRight,
                            height: 10,
                            color: Color(0xFFEF574B),
                            child: Container(
                                height: 28,
                                margin: EdgeInsets.only(right: 25.25),
                                child: Image.asset("app_img/delet.jpg")),
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              subtotal = subtotal -
                                  MyAppState.of(context)!
                                      .inCart[index]
                                      .price!;
                              MyAppState.of(context)?.inCart[index].qty =
                                  null;
                              onBack(MyAppState.of(context)?.inCart,
                                  context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${MyAppState.of(context)?.inCart[index].title} removed from cart')));
                              MyAppState.of(context)
                                  ?.inCart
                                  .removeAt(index);
                            });
                          },
                          child: Container(
                            width: 380,
                            height: 100,
                            color: Colors.white,
                            margin:
                                EdgeInsets.only(left: 17, top: 26, right: 17),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 64,
                                                height: 64,
                                                margin: EdgeInsets.only(
                                                    left: 15, top: 14),
                                                decoration: BoxDecoration(
                                                    color: MyAppState.of(
                                                            context)
                                                        ?.productcolor[index],
                                                    shape: BoxShape.circle),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 19, top: 30),
                                                width: 55,
                                                height: 56,
                                                child: Image.network(
                                                    MyAppState.of(
                                                            context)
                                                        ?.inCart[index]
                                                        .image as String),
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 22, left: 22),
                                                child: Text(
                                                  "\$${MyAppState.of(context)?.inCart[index].price} x ${MyAppState.of(context)?.inCart[index].qty}",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: Color(0xFF6CC51D)),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 22),
                                                child: Text(
                                                    MyAppState.of(
                                                                context)
                                                            ?.inCart[index]
                                                            .title ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: Colors.black)),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 22),
                                                child: Text(
                                                    MyAppState.of(
                                                                context)
                                                            ?.inCart[index]
                                                            .unit ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFF868889))),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 21),
                                        child: Text(
                                            "\$ ${MyAppState.of(context)!.inCart[index].qty! * MyAppState.of(context)!.inCart[index].price!}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Color(0xFF868889))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 414,
                    height: 234,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 22, left: 17),
                              child: Text(
                                "Subtotal",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF868889)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 22, right: 17),
                              child: Text("\$ $subtotal",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF868889))),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 7, left: 17),
                              child: Text(
                                "Subtotal",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF868889)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7, right: 17),
                              child: Text("\$ 1.6",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF868889))),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFFEBEBEB),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 7, left: 17),
                              child: Text(
                                "Total",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7, right: 17),
                              child: Text(
                                  "\$ ${(subtotal + 1.6).toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CheckoutScreen()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 16, left: 17),
                              child: CustomBTN(
                                name: 'Checkout',
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          : Center(child: Text("Nothing added in cart")),
    );
  }
}
