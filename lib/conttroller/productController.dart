import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:raoyal_house/app%20utils/firebase.dart';
import 'package:raoyal_house/models/product.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<Product> products = RxList<Product>();
  RxList<Product> featureProducts = RxList<Product>();
  Product? productModel;

  String collection = "products";
  @override
  void onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
    featureProducts.bindStream(getFeatureProducts());
  }

  Stream<List<Product>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => Product.fromJason(item.data())).toList());

  Stream<List<Product>> getFeatureProducts() => firebaseFirestore
      .collection(collection)
      .where('feature', isEqualTo: true)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => Product.fromJason(e.data())).toList());
}
