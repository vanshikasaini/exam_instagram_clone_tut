// user already login
import 'package:exam_instagram_clone_tut/state/auth/providers/auth_state_provider.dart';
import 'package:exam_instagram_clone_tut/views/components/dialogs/alert_dialog_model.dart';
import 'package:exam_instagram_clone_tut/views/components/dialogs/logout_dialog.dart';
import 'package:exam_instagram_clone_tut/views/constants/strings.dart';
import 'package:exam_instagram_clone_tut/views/tabs/users_posts/user_posts_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// must sure that screen must be mounted to do animation
//so mounted properrty is in StatefulWidgets

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              onPressed: () async {},
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
            ),
            IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);

                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.person,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.search,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.home,
              ),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            UserPostsView(),
            UserPostsView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
