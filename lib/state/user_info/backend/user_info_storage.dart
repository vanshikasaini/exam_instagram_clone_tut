import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_instagram_clone_tut/state/constants/firebase_collection_name.dart';
import 'package:exam_instagram_clone_tut/state/constants/firebase_field_name.dart';
import 'package:exam_instagram_clone_tut/state/posts/typedefs/user_id.dart';
import 'package:exam_instagram_clone_tut/state/user_info/models/user_info_payload.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectiondName.users,
            //first check if we have user info before in the storage
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have this user's info
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }
      // we do not have this user's info from before, create a new user
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectiondName.users,
          )
          .add(payload);

      return true;
    } catch (e) {
      return false;
    }
  }
}
