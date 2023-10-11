import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    super.key,
    required RiveAnimationController btnAnimation,
    required this.onPressed,
  }) : _btnAnimation = btnAnimation;

  final RiveAnimationController _btnAnimation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 64,
          width: 260,
          child: Stack(
            children: <Widget>[
              RiveAnimation.asset("assets/RiveAssets/button.riv",
                  controllers: [_btnAnimation]),
              const Positioned.fill(
                top: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(CupertinoIcons.arrow_right),
                    const SizedBox(width: 8),
                    Text(
                      "Start the Course",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
