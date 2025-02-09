import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _auth = Supabase.instance.client.auth;

  @override
  Stream<User?> build() async* {
    if (_auth.currentSession == null) {
      await _auth.signInAnonymously();
    }

    yield* _auth.onAuthStateChange.map((e) => e.session?.user);
  }
}
