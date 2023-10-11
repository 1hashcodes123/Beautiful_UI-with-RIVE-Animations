import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/entry_point_screen.dart';
import 'package:rive_animation/utilis/rive_utilis.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SMITrigger reset;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger confetti;

  bool isButtonTapped = false;
  bool isConfetti = false;
  bool isTapped = false;
  


  void signIn(BuildContext context) {
    setState(() {
      isButtonTapped = true;
      isConfetti = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
        check.fire();
        Future.delayed(
          const Duration(seconds: 2),
          () {
            setState(() {
              isButtonTapped = false;
            });
            confetti.fire();
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EntryPointScreen()));
            });
          },
        );
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isButtonTapped = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Email",
              style: TextStyle(color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
                onSaved: (email) {},
                decoration: InputDecoration(
                  prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset("assets/icons/email.svg")),
                ),
              ),
            ),
            const Text(
              "Password",
              style: TextStyle(color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
                onSaved: (password) {},
                obscureText: isTapped ? true : false,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset("assets/icons/password.svg"),
                  ),
                  suffixIcon: IconButton(
                    icon: isTapped
                        ? const Icon(
                            CupertinoIcons.eye_slash,
                            color: Color(0xfff77d8e),
                          )
                        : const Icon(
                            CupertinoIcons.eye,
                            color: Color(0xfff77d8e),
                          ),
                    onPressed: () {
                      setState(
                        () {
                          isTapped = !isTapped;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    signIn(context);
                  },
                  icon: const Icon(CupertinoIcons.arrow_right,
                      color: Color(0xfffe0037)),
                  label: const Text("Sign In"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff77d8e),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25)).copyWith(
                        topLeft: const Radius.circular(10),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
      isButtonTapped
          ? CustomConfirmation(
              child: RiveAnimation.asset(
                "assets/RiveAssets/check.riv",
                onInit: (artboard) {
                  StateMachineController controller =
                      RiveUtilis.getRiveController(artboard);
                  check = controller.findSMI("Check") as SMITrigger;
                  error = controller.findSMI("Error") as SMITrigger;
                  reset = controller.findSMI("Reset") as SMITrigger;
                },
              ),
            )
          : const SizedBox(),
      isConfetti
          ? CustomConfirmation(
              child: Transform.scale(
                  scale: 6,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: (artboard) {
                      StateMachineController controller =
                         RiveUtilis.getRiveController(artboard);
                      confetti =
                          controller.findSMI("Trigger explosion") as SMITrigger;
                    },
                  )),
            )
          : const SizedBox(),
    ]);
  }
}

class CustomConfirmation extends StatelessWidget {
  const CustomConfirmation({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(children: <Widget>[
        const Spacer(),
        SizedBox(
          width: size,
          height: size,
          child: child,
        ),
        const Spacer(flex: 2),
      ]),
    );
  }
}
