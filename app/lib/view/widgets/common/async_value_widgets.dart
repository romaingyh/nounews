import 'package:flutter/material.dart';
import 'package:nounews_app/res/theme/constants.dart';

AsyncLoadingWidget Function() asyncLoadingWidgetBuilder = () => const AsyncLoadingWidget();

AsyncLoadingWidget Function() asyncLoadingWidgetBuilderSliver = () => const AsyncLoadingWidget(sliver: true);

class AsyncLoadingWidget extends StatelessWidget {
  const AsyncLoadingWidget({
    super.key,
    this.sliver = false,
  });

  final bool sliver;

  @override
  Widget build(BuildContext context) {
    const content = Center(child: CircularProgressIndicator.adaptive());

    if (sliver) {
      return const SliverToBoxAdapter(child: content);
    }

    return content;
  }
}

AsyncErrorWidget Function(Object? err, StackTrace? stack) asyncErrorWidgetBuilder = (Object? err, StackTrace? stack) {
  return AsyncErrorWidget(err: err, stack: stack);
};

AsyncErrorWidget Function(Object? err, StackTrace? stack) asyncErrorWidgetBuilderSliver =
    (Object? err, StackTrace? stack) {
  return AsyncErrorWidget(err: err, stack: stack, sliver: true);
};

AsyncErrorWidget Function(Object? err, StackTrace? stack) asyncErrorWidgetBuilderWithPop =
    (Object? err, StackTrace? stack) {
  return AsyncErrorWidget(err: err, stack: stack, canPop: true);
};

class AsyncErrorWidget extends StatelessWidget {
  const AsyncErrorWidget({
    super.key,
    required this.err,
    required this.stack,
    this.showDetails = true,
    this.canPop = false,
    this.sliver = false,
  });

  final Object? err;
  final StackTrace? stack;
  final bool showDetails;
  final bool canPop;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    debugPrint(err.toString());
    debugPrint(stack.toString());

    final content = SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              children: [
                const Text('Erreur de chargement'),
                if (showDetails) Text(err.toString()),
                if (canPop)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Retour'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    if (sliver) {
      return SliverToBoxAdapter(child: content);
    }

    return content;
  }
}
