import 'package:nounews_app/models/feed_preview_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_feed_providers.g.dart';

@riverpod
class FeedCreator extends _$FeedCreator {
  final FunctionsClient _client = Supabase.instance.client.functions;

  @override
  FutureOr<FeedPreviewModel?> build() {
    return null;
  }

  Future<void> createFromUri(Uri uri) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        final response = await _client.invoke(
          'fetch_articles',
          body: {
            'url': uri.toString(),
          },
        );

        final json = response.data as Map<String, dynamic>;

        return FeedPreviewModel.fromJson(json);
      } on FunctionException catch (e) {
        throw e.details as String;
      }
    });
  }
}
