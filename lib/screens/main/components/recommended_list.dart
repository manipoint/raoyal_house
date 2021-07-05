import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/app%20utils/controllers.dart';
import 'package:raoyal_house/app%20utils/loading.dart';
import 'package:raoyal_house/models/product.dart';
import 'package:raoyal_house/screens/product/product_page.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../app utils/app_properties.dart';

class RecommendedList extends StatelessWidget {
   List<Product> product = productController.products;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                'Recommended',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              itemCount: product.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => Get.to(ProductPage(product: product[index])),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                            center: Alignment(0, 0),
                            radius: .6,
                            focal: Alignment(0, 0),
                            colors: [
                              Colors.grey.shade500,
                              Colors.grey.shade700
                            ],
                            focalRadius: 0.1),
                      ),
                      child: Hero(
                        tag: product[index].picture!,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            )),
                            FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: product[index].picture!,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
