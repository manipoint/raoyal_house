import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raoyal_house/app%20utils/controllers.dart';


import '../../app utils/app_properties.dart';
import 'register_page.dart';

class WelcomeBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget welcomeBack = Text(
      'Welcome Back ',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Login to your account with email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 5,
      child: InkWell(
        onTap: () => authController.signIn(),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 60,
          child: Center(
              child: new Text("Log In",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(236, 60, 3, 1),
                    Color.fromRGBO(234, 60, 3, 1),
                    Color.fromRGBO(216, 78, 16, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(
      height: MediaQuery.of(context).size.width/1.6,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width /1.85,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined),
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "Email"),
                controller: authController.email,
                style: TextStyle(fontSize: 20.0),
              ),
               Padding(
                 padding: const EdgeInsets.only(bottom: 16),
                 child: TextField(
                   controller: authController.password,
                   decoration: InputDecoration(
                       icon: Icon(Icons.lock),
                       fillColor: Colors.white,
                       border: InputBorder.none,
                       hintText: "Password"),
                   style: TextStyle(fontSize: 20.0),
                   obscureText: true,
                 ),
               ),
              ],
            ),
          ),
          loginButton,
        ],
      ),
    );

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot your password? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 18.0,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(RegisterPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(left:8),
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow.withOpacity(.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 4),
                welcomeBack,
                Spacer(),
                subTitle,
                Spacer(flex: 4),
                loginForm,
                Spacer(flex: 4),
                forgotPassword,
                Spacer(flex: 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
