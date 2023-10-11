import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.pressed,
    required this.oninit,
  });
  final VoidCallback pressed;
  final ValueChanged<Artboard> oninit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: pressed,
        child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: RiveAnimation.asset("assets/RiveAssets/menu_button.riv",
                onInit: oninit)),
      ),
    );
  }
}

