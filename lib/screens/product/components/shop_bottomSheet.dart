
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/app%20utils/app_properties.dart';
import 'package:raoyal_house/app%20utils/controllers.dart';
import 'package:raoyal_house/custom/custom_text.dart';

import 'shop_product.dart';

class ShopBottomSheet extends StatelessWidget {

 // final List<CartModel> cartitem = authController.userModel.value.cart!;
  @override
  Widget build(BuildContext context) {
    Widget confirmButton = InkWell(
      onTap: () async {
        // Navigator.of(context).pop();
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => CheckOutPage()));
      },
      child: Obx(()=>Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 20
                : MediaQuery.of(context).padding.bottom),
        child: Center(
            child: Text("Pay ${cartController.totalCartPrice.toString().obs}",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0))),
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
      ),)
    );

    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Image.asset(
                  'assets/box.png',
                  height: 24,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
                onPressed: () {},
                iconSize: 48,
              ),
            ),
            SizedBox(
              height: 300,
              child:     ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: authController.userModel.value.cart!
                  .map((e){
                    return CartItemWidget(cartItem: e,);
                  }).toList()
                      
                )),
          ],
        ), 
            ),
            confirmButton,
          ],
        ));
  }
}
