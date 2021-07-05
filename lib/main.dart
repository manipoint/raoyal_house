import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/conttroller/cart_controller.dart';
import 'package:raoyal_house/screens/splash_page.dart';

import 'app utils/firebase.dart';
import 'conttroller/app_controller.dart';
import 'conttroller/auth.dart';
import 'conttroller/productController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization.then((value) {
    Get.put(AuthController());
    Get.put(ProductController());
    Get.put(AppController());
    Get.put(CartController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Royal House',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen(),
    );
  }
}
