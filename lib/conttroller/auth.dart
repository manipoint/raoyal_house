import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/app%20utils/firebase.dart';
import 'package:raoyal_house/app%20utils/loading.dart';
import 'package:raoyal_house/models/user.dart';
import 'package:raoyal_house/screens/auth/welcome_back_page.dart';
import 'package:raoyal_house/screens/main/main_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController titel = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  //address
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController postcode = TextEditingController();

  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => WelcomeBackPage());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => MainPage());
    }
  }

  void signIn() async {
    try {
      Loading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp() async {
    Loading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Signup Failed", "Try again");
    }
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": {
        "title": titel.text,
        "first": firstName.text,
        "last": lastName.text
      },
      "id": userId,
      "email": email.text.toLowerCase().trim(),
      "phone": phone.text.trim(),
      "cart": [],
      "location": {
        "street": street.text,
        "city": city.text,
        "state": state.text,
        "postcode": postcode.text,
      }
    });
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => auth.authStateChanges();

//Streams the firestore user from the firestore collection
  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((query) => UserModel.fromJson(query.data()!));

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .get()
        .then(
            (documentSnapshot) => UserModel.fromJson(documentSnapshot.data()!));
  }

  _clearControllers() {
    titel.clear();
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
    phone.clear();
    state.clear();
    city.clear();
    street.clear();
    postcode.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  deleteUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
    ;
  }
}
