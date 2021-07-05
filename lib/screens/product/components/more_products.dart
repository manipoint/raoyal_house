import 'package:flutter/material.dart';
import 'package:raoyal_house/app%20utils/controllers.dart';
import 'package:raoyal_house/models/product.dart';
import 'package:raoyal_house/screens/main/components/product_list.dart';

import '../../../app utils/app_properties.dart';

class MoreProducts extends StatelessWidget {
  final List<Product?> products = productController.products;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 8.0),
          child: Text(
            'More products',
            style: TextStyle(color: Colors.white, shadows: shadow),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          height: 250,
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) {
              return Padding(

                  ///calculates the left and right margins
                  ///to be even with the screen margin
                  padding: index == 0
                      ? EdgeInsets.only(left: 24.0, right: 8.0)
                      : index ==4
                          ? EdgeInsets.only(right: 24.0, left: 8.0)
                          : EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProductCard(product: products[index],height: 250,width: 250,));
            },
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }
}
