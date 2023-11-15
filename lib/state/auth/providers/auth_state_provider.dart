import 'package:exam_instagram_clone_tut/state/auth/models/auth_state.dart';
import 'package:exam_instagram_clone_tut/state/auth/notifiers/auth_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//--> StateNotifierProvider<StateNotifier , StateNotifier Object>
//authStateProvider is the listener of AuthStateNotifier whenever the state changes inside AuthStateNotifier
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
