import 'package:exam_instagram_clone_tut/state/auth/models/auth_result.dart';
import 'package:exam_instagram_clone_tut/state/posts/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

/// show immutable --> we don't required entire foundation package
/// using only for this tag immutable

@immutable
class AuthState {
  final AuthResults? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState(
      {required this.result, required this.isLoading, required this.userId});

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copiedWithIsLoading(bool isLoading) =>
      AuthState(result: result, isLoading: isLoading, userId: userId);

  // It is important to implement equality and hash values for your models objects and
  // ensure that they are designed as expected

  // boolean getter for equality --> If equality operator is override so it is important
  //to override the [hashCode] method as well to maintain consistency.
  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        result,
        isLoading,
        userId,
      );
}
