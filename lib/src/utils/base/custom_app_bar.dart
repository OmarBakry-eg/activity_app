import 'package:activity_app/src/utils/ui/consts.dart';
import 'package:activity_app/src/utils/ui/routing/route_strings.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hideAddButton, centerTitle;
  const HomeAppBar(
      {Key? key, this.centerTitle = false, this.hideAddButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        hideAddButton
            ? const Offstage()
            : IconButton(
                iconSize: 30,
                onPressed: () =>
                    Constants.navigateTo(RouteStrings.activityPageString),
                icon: const Icon(Icons.add_circle_outline_outlined)),
      ],
      centerTitle: centerTitle,
      backgroundColor: const Color(0xff6035d0),
      title: const Text(
        "Activites",
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xffffffff),
          letterSpacing: 2.016,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
