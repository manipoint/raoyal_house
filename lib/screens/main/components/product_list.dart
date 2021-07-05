import 'package:flutter/material.dart';
import 'package:flutter_page_indicator_tv/flutter_page_indicator.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/app%20utils/controllers.dart';
import 'package:raoyal_house/app%20utils/loading.dart';
import 'package:raoyal_house/models/product.dart';
import 'package:raoyal_house/screens/product/product_page.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../app utils/app_properties.dart';

class ProductList extends StatelessWidget {
  final List<Product>? products = productController.featureProducts;
  final SwiperController swiperController = SwiperController();

  ProductList(List<Product>? products);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 3;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;
    return SizedBox(
      height: cardHeight,
      child: Swiper(
        itemCount: productController.featureProducts.length,
        itemBuilder: (_, index) {
          return ProductCard(
              height: cardHeight, width: cardWidth, product: products![index]);
        },
        scale: .8,
        controller: swiperController,
        viewportFraction: .65,
        loop: false,
        fade: 0.5,
        pagination: SwiperCustomPagination(
          builder: (context, config) {
            if (config!.itemCount! > 20) {
              print(
                  "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
            }
            Color activeColor = mediumYellow;
            Color color = Colors.grey.shade300;
            double size = 10.0;
            double space = 5.0;

            if (config.layout == SwiperLayout.DEFAULT) {
               Obx(()=> PageIndicator(
                count: config.itemCount!,
                controller: config.pageController!,
                layout: PageIndicatorLayout.SLIDE,
                size: size,
                activeColor: activeColor,
                color: color,
                space: space,
              ));
            }

            List<Widget> dots = [];

            int itemCount = config.itemCount!;
            int activeIndex = config.activeIndex!;

            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              dots.add(Container(
                key: Key("pagination_$i"),
                margin: EdgeInsets.all(space),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? activeColor : color,
                    ),
                    width: size,
                    height: size,
                  ),
                ),
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: dots,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product? product;
  final double? height;
  final double? width;

  const ProductCard({Key? key, this.product, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ProductPage(product: product)),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: mediumYellow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                  color: Colors.red,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product!.name!,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(224, 69, 10, 1),
                        ),
                        child: Text(
                          product!.price.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            child: Hero(
              tag: product!.id!,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Loading()),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: product!.picture!,
                    fit: BoxFit.fill,
                    height: height! / 1.7,
                    width: width! / 1.3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
