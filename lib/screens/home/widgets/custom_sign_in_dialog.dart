import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/screens/home/widgets/sign_in_form.dart';

Future<Object?> customSignInDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    transitionDuration: const Duration(milliseconds: 400),
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      tween = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: BorderRadius.circular(40)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: <Widget>[
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                        "Don't Skip design. Learn design and code, by building real apps with Flutter and Swift. Complete Course about the best tools.",
                        textAlign: TextAlign.center),
                  ),
                  const SignInForm(),
                  const Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(thickness: 0.7),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.black26),
                          )),
                      Expanded(
                        child: Divider(thickness: 0.7),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text("Sign up with Email, Apple or Google"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          "assets/icons/email_box.svg",
                          height: 64,
                          width: 64,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          "assets/icons/apple_box.svg",
                          height: 64,
                          width: 64,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset("assets/icons/google_box.svg",
                            height: 64, width: 64),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: -48,
                child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    ),
  ).then(onClosed);
}
