import 'package:exam_instagram_clone_tut/state/auth/backend/authenticator.dart';
import 'package:exam_instagram_clone_tut/state/auth/models/auth_result.dart';
import 'package:exam_instagram_clone_tut/state/auth/models/auth_state.dart';
import 'package:exam_instagram_clone_tut/state/posts/typedefs/user_id.dart';
import 'package:exam_instagram_clone_tut/state/user_info/backend/user_info_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//StateNotifier like stream it going to notify all listeners when state value is changed
class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userStorageInfo = const UserInfoStorage();

  // initially Notifier has unknown state then check
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResults.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }
// Authenticator -- just has functions but does not contain results or state
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResults.success && userId != null) {
      // should store data into firebase storage
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResults.success && userId != null) {
      // should store data into firebase storage
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userStorageInfo.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
