import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/app%20utils/controllers.dart';
import 'package:raoyal_house/models/cart.dart';
import 'package:raoyal_house/models/product.dart';
import 'package:raoyal_house/models/user.dart';

import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  Rx<CartModel> cartModel = CartModel().obs;
  Rx<double> totalCartPrice = 0.0.obs;
  RxInt quantaty = 1.obs;

  @override
  void onReady() {
    super.onReady();
    ever(authController.userModel, changeCartTotalPrice);
    ever(cartController.cartModel, decreaseQuantity);
    ever(cartController.cartModel, increaseQuantity);
  }

  void addProductToCart(Product product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = Uuid().v1();
        authController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "quantity": quantaty.toInt(),
              "price": product.price,
              "picture": product.picture,
              "cost": product.price!
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartModel cartItem) {
    try {
      authController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item + ${e.toString()}");
      debugPrint(e.toString());
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart!.isNotEmpty) {
      authController.userModel.value.cart!.forEach((cartItem) {
        totalCartPrice.value += cartItem.price! * cartItem.quantity!;
      });
    }
  }

  bool _isItemAlreadyAdded(Product product) =>
      authController.userModel.value.cart!
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(CartModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      //print("before decrese ${item.quantity}");
      quantaty.value = item.quantity!;
      quantaty.value--;
      //update quantity every time
      item.quantity = quantaty.value;
      //update price every time when quantity increase or decrease
      item.cost = item.price! * item.quantity!;

      //print("After decrese ${item.quantity!}");
      authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
    quantaty.value = 1;
  }

  void increaseQuantity(CartModel item) {
    removeCartItem(item);
    // print("before increse ${item.quantity}");
    quantaty.value = item.quantity!;
    quantaty.value++;
    item.quantity = quantaty.value;

    item.cost = item.price! * item.quantity!;
    // print("After increase ${item.quantity!}");
    // logger.i({"quantity": item.quantity});
    authController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
    quantaty.value = 1;
  }
}
