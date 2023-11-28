import 'package:exam_instagram_clone_tut/state/posts/models/post.dart';
import 'package:exam_instagram_clone_tut/views/components/post/post_thumbnail_view.dart';
import 'package:flutter/material.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: ((context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {},
        );
      }),
    );
  }
}
