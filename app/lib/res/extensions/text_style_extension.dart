import 'package:flutter/material.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';

extension TextStyleX on TextStyle? {
  TextStyle? secondary(BuildContext context) => this?.copyWith(color: context.colorScheme.onSurfaceVariant);
}
