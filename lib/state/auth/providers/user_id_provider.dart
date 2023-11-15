import 'package:exam_instagram_clone_tut/state/auth/providers/auth_state_provider.dart';
import 'package:exam_instagram_clone_tut/state/posts/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider<UserId?>(
  (ref) => ref.watch(authStateProvider).userId,
);
