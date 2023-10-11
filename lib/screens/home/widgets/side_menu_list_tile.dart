import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/models/rive_asset.dart';

class SideMenuListTile extends StatelessWidget {
  const SideMenuListTile({
    required this.menu,
    required this.press,
    required this.riveinit,
    required this.selectedMenu,
    super.key,
  });
  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveinit;
  final RiveAsset selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Divider(height: 1, color: Colors.white30),
      ),
      Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            height: 56,
            width: selectedMenu == menu ? 288 : 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff6792ff),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          ListTile(
            onTap: press,
            leading: SizedBox(
              height: 34,
              width: 34,
              child: RiveAnimation.asset(
                menu.src,
                artboard: menu.artboard,
                onInit: riveinit,
              ),
            ),
            title: Text(
              menu.title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ]);
  }
}
