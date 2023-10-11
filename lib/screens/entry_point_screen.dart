import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/models/rive_asset.dart';
import 'package:rive_animation/screens/home/home_screen.dart';
import 'package:rive_animation/screens/home/widgets/animated_bar.dart';
import 'package:rive_animation/screens/home/widgets/menu_button.dart';
import 'package:rive_animation/screens/home/widgets/side_menu.dart';
import 'package:rive_animation/utilis/rive_utilis.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedBottomNav = bottomNavs[0];
  late SMIBool isMenuOpen;
  bool isSideMenuOpened = false;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> _scaleAnimation;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: _animationController));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(children: <Widget>[
        AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuOpened ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideMenu()),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: ClipRRect(
                borderRadius: animation.value == 1
                    ? BorderRadius.circular(30)
                    : BorderRadius.zero,
                child: const HomeScreen(),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: isSideMenuOpened ? 0 : 220,
            curve: Curves.fastOutSlowIn,
            top: 16,
            child: MenuButton(oninit: (artboard) {
              StateMachineController controller = RiveUtilis.getRiveController(
                  artboard,
                  stateMachine: "State Machine");
              isMenuOpen = controller.findSMI("isOpen") as SMIBool;
              isMenuOpen.value = true;
            }, pressed: () {
              isMenuOpen.value = !isMenuOpen.value;

              if (isSideMenuOpened) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuOpened = isMenuOpen.value;
              });
            })),
      ]),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ...List.generate(bottomNavs.length, (index) {
                  return InkWell(
                    onTap: () {
                      if (bottomNavs[index] != selectedBottomNav) {
                        setState(() {
                          selectedBottomNav = bottomNavs[index];
                        });
                      }
                      bottomNavs[index].input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        bottomNavs[index].input!.change(false);
                      });
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          AnimatedBar(
                              isActive: bottomNavs[index] == selectedBottomNav),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Opacity(
                              opacity: bottomNavs[index] == selectedBottomNav
                                  ? 1
                                  : 0.5,
                              child: RiveAnimation.asset(
                                bottomNavs.first.src,
                                artboard: bottomNavs[index].artboard,
                                onInit: (artboard) {
                                  StateMachineController controller =
                                      RiveUtilis.getRiveController(artboard,
                                          stateMachine: bottomNavs[index]
                                              .stateMachineName);
                                  bottomNavs[index].input =
                                      controller.findSMI("active") as SMIBool;
                                },
                              ),
                            ),
                          )
                        ]),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
