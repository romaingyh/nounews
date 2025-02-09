import 'package:flutter/material.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/extensions/text_style_extension.dart';

class FeedChip extends StatelessWidget {
  const FeedChip({
    super.key,
    required this.feedName,
  });

  final String feedName;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(feedName),
      labelStyle: context.textTheme.bodySmall.secondary(context),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
