import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/home/widgets/btn_widget.dart';
import 'package:rive_animation/screens/home/widgets/custom_sign_in_dialog.dart';
import 'package:rive_animation/screens/home/widgets/sign_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignBtnClicked = false;
  late RiveAnimationController _btnAnimation;
  @override
  initState() {
    _btnAnimation = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png",
                width: MediaQuery.of(context).size.width * 1.7),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isSignBtnClicked ? -50 : 0,
            duration: const Duration(milliseconds: 400),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Learn design & Code",
                            style: TextStyle(
                                fontSize: 60,
                                fontFamily: "Poppins",
                                height: 1.2),
                          ),
                          SizedBox(height: 16),
                          Text(
                              "Don't Skip design. Learn design and code, by building real apps with Flutter and Swift. Complete Course about the best tools."),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                        btnAnimation: _btnAnimation,
                        onPressed: () {
                          _btnAnimation.isActive = true;
                          Future.delayed(const Duration(milliseconds: 800), () {
                            customSignInDialog(context, onClosed: (_) {
                              setState(() {
                                isSignBtnClicked = false;
                              });
                            });
                            setState(() {
                              isSignBtnClicked = true;
                            });
                          });
                        }),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                            "Purchase includes access to 30+ courses, 240+ premium tuorials, 120+ hours of videos, source files and certificates"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
