import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    this.hintText = 'Search',
    this.onChanged,
  });

  final String hintText;

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(TablerIcons.search),
        isDense: true,
      ),
    );
  }
}
