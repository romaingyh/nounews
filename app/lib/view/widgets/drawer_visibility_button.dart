import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class DrawerVisibilityButton extends StatelessWidget {
  const DrawerVisibilityButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldState = Scaffold.of(context);

    return IconButton(
      onPressed: () {
        if (scaffoldState.isDrawerOpen) {
          scaffoldState.closeDrawer();
        } else {
          scaffoldState.openDrawer();
        }
      },
      icon: const Icon(TablerIcons.layout_sidebar_left_expand_filled),
    );
  }
}
