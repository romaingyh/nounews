import 'package:flutter/widgets.dart';
import 'package:nounews_app/res/theme/constants.dart';

class EntryAnimatedWidget extends StatefulWidget {
  const EntryAnimatedWidget({
    super.key,
    required this.child,
    this.duration = kMediumAnimationDuration,
    this.curve = Curves.easeInOut,
    this.begin = 0.0,
    this.end = 1.0,
    this.type = AnimationType.scale,
  });

  final Duration duration;

  final Curve curve;

  final double begin;

  final double end;

  final AnimationType type;

  final Widget child;

  @override
  State<EntryAnimatedWidget> createState() => _EntryAnimatedWidgetState();
}

class _EntryAnimatedWidgetState extends State<EntryAnimatedWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animationController.forward();

    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.type) {
      ScaleAnimation(:final alignment) => ScaleTransition(
          alignment: alignment,
          scale: _animation,
          child: widget.child,
        ),
      SizeAnimation(:final axis, :final axisAlignment, :final fixedCrossAxisSizeFactor) => SizeTransition(
          axis: axis,
          axisAlignment: axisAlignment,
          fixedCrossAxisSizeFactor: fixedCrossAxisSizeFactor,
          sizeFactor: _animation,
          child: widget.child,
        ),
      FadeAnimation _ => FadeTransition(
          opacity: _animation,
          child: widget.child,
        ),
    };
  }
}

sealed class AnimationType {
  const AnimationType();

  static const ScaleAnimation scale = ScaleAnimation();

  static const SizeAnimation sizeVertical = SizeAnimation.vertical();

  static const SizeAnimation sizeHorizontal = SizeAnimation.horizontal();

  static const FadeAnimation fade = FadeAnimation();
}

class ScaleAnimation extends AnimationType {
  const ScaleAnimation({
    this.alignment = Alignment.center,
  });

  final Alignment alignment;
}

class SizeAnimation extends AnimationType {
  const SizeAnimation.vertical({
    this.axisAlignment = 0.0,
    this.fixedCrossAxisSizeFactor,
  }) : axis = Axis.vertical;

  const SizeAnimation.horizontal({
    this.axisAlignment = 0.0,
    this.fixedCrossAxisSizeFactor,
  }) : axis = Axis.horizontal;

  final Axis axis;

  final double axisAlignment;

  final double? fixedCrossAxisSizeFactor;
}

class FadeAnimation extends AnimationType {
  const FadeAnimation();
}
