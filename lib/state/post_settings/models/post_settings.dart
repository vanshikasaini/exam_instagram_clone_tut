import 'package:exam_instagram_clone_tut/state/post_settings/constants/constants.dart';

enum PostSettings {
  allowLikes(
    title: Constants.allowLikesTitle,
    description: Constants.allowLikesDescription,
    storageKey: Constants.allowCommentsStorageKey,
  ),

  allowComments(
    title: Constants.allowCommentsTitle,
    description: Constants.allowCommentsDescription,
    storageKey: Constants.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSettings({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
