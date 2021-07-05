
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:raoyal_house/models/cart.dart';

import 'package:raoyal_house/screens/product/components/color_list.dart';
import 'package:raoyal_house/screens/product/components/shop_product.dart';

import '../../../app utils/app_properties.dart';

class ShopItemList extends StatefulWidget {
  final CartModel cartProduct;
  final Function onRemove;

  ShopItemList(this.cartProduct, {Key? key,required this.onRemove}) : super(key: key);

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, 0.8),
            child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 12.0, right: 12.0),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.cartProduct.name!,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: darkGrey,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 160,
                                padding: const EdgeInsets.only(
                                    left: 32.0, top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ColorOption(Colors.red),
                                    Text(
                                      'Rs ${widget.cartProduct.price}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: darkGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
//TODO: Work on scroll quantity
                      Theme(
                        data: ThemeData(
                           
                            textTheme: TextTheme(
                              headline5: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              bodyText2: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            )),
                        child: NumberPicker
                        (
                          itemCount: 30,
                          
                          minValue: 1,
                          maxValue: 10,
                          onChanged: (value) {
                            setState(() {
                              quantity = value;
                            });
                          },
                         value: quantity,
                        ),
                      )
                    ])),
          ),
          Positioned(
              top: 5,
              child: ShopProductDisplay(
                widget.cartProduct
              )),
        ],
      ),
    );
  }
}
