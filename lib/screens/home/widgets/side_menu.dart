import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/models/rive_asset.dart';
import 'package:rive_animation/screens/home/widgets/info_card.dart';
import 'package:rive_animation/screens/home/widgets/side_menu_list_tile.dart';
import 'package:rive_animation/utilis/rive_utilis.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: 288,
        color: const Color(0xff17203a),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const InfoCard(name: 'Muhammad Hashir', profession: 'Programmer'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 24, top: 32),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuListTile(
                  menu: menu,
                  riveinit: (artboard) {
                    StateMachineController controller =
                        RiveUtilis.getRiveController(artboard,
                            stateMachine: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  selectedMenu: selectedMenu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus2.map(
                (menu2) => SideMenuListTile(
                    menu: menu2,
                    riveinit: (artboard) {
                      StateMachineController controller =
                          RiveUtilis.getRiveController(artboard,
                              stateMachine: menu2.stateMachineName);
                      menu2.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      menu2.input!.change(true);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        menu2.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu2;
                      });
                    },
                    selectedMenu: selectedMenu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
