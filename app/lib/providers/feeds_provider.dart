import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nounews_app/models/feed_model.dart';
import 'package:nounews_app/res/extensions/iterable_extension.dart';
import 'package:nounews_app/res/extensions/ref_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'feeds_provider.g.dart';

@riverpod
FutureOr<List<FeedModel>> feeds(
  Ref ref, {
  String? query,
}) async {
  await ref.debounce();

  var request = Supabase.instance.client.from('feeds').select();

  if (query != null && query.trim().length > 2) {
    request = request.ilike('feed_title', '%$query%');
  }

  return request.withConverter(
    (data) => data.mapEmptySafe((json) => FeedModel.fromJson(json)).toList(),
  );
}
