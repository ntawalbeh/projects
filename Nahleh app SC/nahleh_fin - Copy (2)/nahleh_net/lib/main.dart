import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nahleh_net/screen/homepage.dart';
import 'package:nahleh_net/widget/constant.dart';
import 'package:page_transition/page_transition.dart';
import './screen/azconnectionpage.dart';

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnimatedSplashScreen(
            duration: 3000,
            splashIconSize: 200,
            splash: Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            nextScreen: HomePageNavigator(),
            splashTransition: SplashTransition.scaleTransition,
            pageTransitionType: PageTransitionType.fade,
            //background color for splash
            backgroundColor: firstColor));
  }
}
