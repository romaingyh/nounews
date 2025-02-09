import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nounews_app/res/theme/constants.dart';

const kTextSwitchAnimDuration = kMediumAnimationDuration;
const kTextSwitchHeight = 30.0;

double _computeRelativeOffset(double index, int labelsCount) {
  return index / labelsCount;
}

class _InheritedTextSwitch extends InheritedWidget {
  const _InheritedTextSwitch({
    required this.style,
    required this.labels,
    required this.onChange,
    required this.onFocusChange,
    required this.selectedIndex,
    required this.isFocused,
    required super.child,
  });

  final TextSwitchStyle style;

  final List<String> labels;

  final ValueChanged<int> onChange;

  final ValueChanged<bool> onFocusChange;

  final int selectedIndex;

  final bool isFocused;

  static _InheritedTextSwitch? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedTextSwitch>();
  }

  @override
  bool updateShouldNotify(_InheritedTextSwitch oldWidget) {
    return style != oldWidget.style ||
        labels != oldWidget.labels ||
        selectedIndex != oldWidget.selectedIndex ||
        isFocused != oldWidget.isFocused ||
        onChange != oldWidget.onChange ||
        onFocusChange != oldWidget.onFocusChange ||
        child != oldWidget.child;
  }
}

class TextSwitch extends StatefulWidget {
  final List<String> labels;
  final Function(int index) onChange;
  final PageController pageController;

  final TextSwitchStyle style;

  const TextSwitch({
    super.key,
    required this.labels,
    required this.onChange,
    required this.pageController,
    this.style = const TextSwitchStyle(),
  });

  @override
  State<TextSwitch> createState() => _TextSwitchState();
}

class _TextSwitchState extends State<TextSwitch> {
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;
  int _selected = 0;
  double _position = 0;

  PageController get _pageController => widget.pageController;

  @override
  void initState() {
    _selected = _pageController.initialPage;
    _position = _pageController.initialPage.toDouble();
    _pageController.addListener(_pageControllerListener);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageControllerListener);
    _focusNode.dispose();
    super.dispose();
  }

  void _pageControllerListener() {
    setState(() {
      _position = _pageController.page ?? _pageController.initialPage.toDouble();
      _selected = _position.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = widget.style.getEffectiveBackgroundColor(context);
    var fgColor = widget.style.getEffectiveForegroundColor(context);

    if (_isFocused) {
      fgColor = theme.splashColor;
    }

    return _InheritedTextSwitch(
      style: widget.style,
      labels: widget.labels,
      onChange: widget.onChange,
      onFocusChange: (value) => setState(() => _isFocused = value),
      selectedIndex: _selected,
      isFocused: _isFocused,
      child: _TextSwitchFocus(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: _computeRelativeOffset(_position, widget.labels.length) * width,
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: width / widget.labels.length,
                        maxHeight: kTextSwitchHeight,
                      ),
                      decoration: BoxDecoration(
                        color: fgColor,
                        borderRadius: BorderRadius.circular(kBorderRadius - 2),
                      ),
                    ),
                  ),
                  const _TextSwitchLabelsRow(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StandaloneTextSwitch extends StatefulWidget {
  final List<String> labels;

  final Function(int index) onChange;

  final int initialIndex;

  final TextSwitchStyle style;

  const StandaloneTextSwitch({
    super.key,
    required this.labels,
    required this.onChange,
    this.initialIndex = 0,
    this.style = const TextSwitchStyle(),
  });

  @override
  State<StandaloneTextSwitch> createState() => _StandaloneTextSwitchState();
}

class _StandaloneTextSwitchState extends State<StandaloneTextSwitch> {
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;
  int _selected = 0;

  @override
  void initState() {
    _selected = widget.initialIndex;

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = widget.style.getEffectiveBackgroundColor(context);
    var fgColor = widget.style.getEffectiveForegroundColor(context);

    if (_isFocused) {
      fgColor = theme.splashColor;
    }

    return _InheritedTextSwitch(
      style: widget.style,
      labels: widget.labels,
      onChange: onChange,
      onFocusChange: (value) => setState(() => _isFocused = value),
      selectedIndex: _selected,
      isFocused: _isFocused,
      child: _TextSwitchFocus(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  AnimatedPadding(
                    duration: kTextSwitchAnimDuration,
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.only(
                      left: _computeRelativeOffset(_selected.toDouble(), widget.labels.length) * width,
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: width / widget.labels.length,
                        maxHeight: kTextSwitchHeight,
                      ),
                      decoration: BoxDecoration(
                        color: fgColor,
                        borderRadius: BorderRadius.circular(kBorderRadius - 2),
                      ),
                    ),
                  ),
                  const _TextSwitchLabelsRow(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void onChange(int index) {
    setState(() {
      _selected = index;
      widget.onChange(index);
    });
  }
}

class _TextSwitchFocus extends HookWidget {
  const _TextSwitchFocus({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    final config = _InheritedTextSwitch.of(context)!;
    final selectedIndex = config.selectedIndex;

    return Focus(
      focusNode: focusNode,
      onFocusChange: config.onFocusChange,
      onKeyEvent: (node, event) {
        if (config.isFocused && event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft && selectedIndex > 0) {
            config.onChange(selectedIndex - 1);
            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.arrowRight && selectedIndex < config.labels.length - 1) {
            config.onChange(selectedIndex + 1);
            return KeyEventResult.handled;
          }
        }

        return KeyEventResult.ignored;
      },
      child: child,
    );
  }
}

class _TextSwitchLabelsRow extends StatelessWidget {
  const _TextSwitchLabelsRow();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = _InheritedTextSwitch.of(context)!;

    final labels = config.labels;
    final selectedIndex = config.selectedIndex;
    final style = config.style;

    return Row(
      children: labels.map((e) {
        final index = labels.indexOf(e);
        final isSelected = selectedIndex == index;

        final textColor =
            isSelected ? (style.selectedTextColor ?? theme.colorScheme.primary) : style.unSelectedTextColor;

        return Expanded(
          child: GestureDetector(
            onTap: () => config.onChange(index),
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: _FadeText(
                label: e,
                selected: isSelected,
                color: textColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FadeText extends StatelessWidget {
  const _FadeText({
    required this.label,
    required this.color,
    this.selected = false,
  });

  final String label;
  final bool selected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium;

    return AnimatedDefaultTextStyle(
      style: style!.copyWith(color: color),
      duration: kTextSwitchAnimDuration,
      child: Text(label),
    );
  }
}

class TextSwitchStyle {
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? selectedTextColor;
  final Color? unSelectedTextColor;

  const TextSwitchStyle({
    this.foregroundColor,
    this.backgroundColor,
    this.selectedTextColor,
    this.unSelectedTextColor,
  });

  Color getEffectiveForegroundColor(BuildContext context) {
    return foregroundColor ?? Theme.of(context).colorScheme.surface;
  }

  Color getEffectiveBackgroundColor(BuildContext context) {
    return backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer;
  }

  TextSwitchStyle copyWith({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? selectedTextColor,
    Color? unSelectedTextColor,
  }) {
    return TextSwitchStyle(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      unSelectedTextColor: unSelectedTextColor ?? this.unSelectedTextColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TextSwitchStyle &&
        other.foregroundColor == foregroundColor &&
        other.backgroundColor == backgroundColor &&
        other.selectedTextColor == selectedTextColor &&
        other.unSelectedTextColor == unSelectedTextColor;
  }

  @override
  int get hashCode {
    return foregroundColor.hashCode ^
        backgroundColor.hashCode ^
        selectedTextColor.hashCode ^
        unSelectedTextColor.hashCode;
  }
}
