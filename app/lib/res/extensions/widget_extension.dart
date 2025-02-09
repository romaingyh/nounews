import 'package:flutter/material.dart';

extension WidgetX on Widget {
  SliverToBoxAdapter get sliver => SliverToBoxAdapter(child: this);
}
