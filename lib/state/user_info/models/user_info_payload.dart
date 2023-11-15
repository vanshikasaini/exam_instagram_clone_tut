import 'dart:collection' show MapView;

import 'package:exam_instagram_clone_tut/state/constants/firebase_field_name.dart';
import 'package:exam_instagram_clone_tut/state/posts/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );

  //serializing into dictionary by calling super so in super just create a dictionary
  // that's how u serialize ur values into MapView
  // now instances of UserInfoPayload are able to be stored directly into a cloud firestore
}
