import 'dart:async';

import 'package:alalmiya_g2/core/logic/cache_helper.dart';
import 'package:alalmiya_g2/main.dart';
import 'package:alalmiya_g2/views/home/view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../login/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CacheHelper.isAuth() ? HomeView() : LoginView(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              bottom: -60,
              left: 50,
              child: Image.asset(
                "assets/images/side.png",
              )),
          Image.asset(
            "assets/images/splash_bg.png",
            height: double.infinity,
            width: double.infinity,
            color: Color(0xff4C8613).withOpacity(.2),
            fit: BoxFit.fill,
          ),
          Center(
            child: FlipInY(
              child: ElasticInUp(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 160,
                  width: 160,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
