import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:nounews_app/res/extensions/context_extension.dart';
import 'package:nounews_app/res/theme/constants.dart';

class FeedCreationAnimatedIcon extends StatefulWidget {
  const FeedCreationAnimatedIcon({
    required this.isLoading,
    this.errorMessage,
  });

  final bool isLoading;

  final String? errorMessage;

  @override
  State<FeedCreationAnimatedIcon> createState() => _FeedCreationAnimatedIconState();
}

class _FeedCreationAnimatedIconState extends State<FeedCreationAnimatedIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCirc,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FeedCreationAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.reset();
      }
    }

    if (widget.errorMessage != oldWidget.errorMessage) {
      _controller.stop();
      _controller.reset();
    }
  }

  Color get _color => switch (widget.errorMessage != null) {
        true => Colors.red,
        false => context.colorScheme.primary,
      };

  @override
  Widget build(BuildContext context) {
    final Widget icon = Icon(
      TablerIcons.file_rss,
      size: 128,
      color: _color,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final double radius = widget.isLoading ? 20 : 0;

            // animate circle around origin
            final double angle = 2 * pi * _animation.value;

            final double xOffset = cos(angle) * radius;
            final double yOffset = sin(angle) * radius;

            return Transform.translate(
              offset: Offset(xOffset, yOffset),
              child: child,
            );
          },
          child: icon,
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: kPadding),
          Text(
            widget.errorMessage!,
            style: context.textTheme.titleSmall?.copyWith(color: _color),
          ),
        ],
      ],
    );
  }
}
