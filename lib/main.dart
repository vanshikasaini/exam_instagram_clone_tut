import 'package:exam_instagram_clone_tut/state/auth/providers/auth_state_provider.dart';
import 'package:exam_instagram_clone_tut/state/auth/providers/is_logged_in_provider.dart';
import 'package:exam_instagram_clone_tut/state/providers/is_loading_provider.dart';
import 'package:exam_instagram_clone_tut/views/components/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

/// https://firebase.google.com/docs/flutter/setup?platform=ios
/// follow above instructions to install firebase CLI
/// image package for thumbnail for photos, for equality used collection package
///  intl for internalization - datetime format
/// video_thumbnail ,lottie - animations
/// share_plus -- native dialog/sheet for share on medias
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.blueGrey,
      //   indicatorColor: Colors.blueGrey,
      // ),
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.blue,
      // ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          // take care of displaying the loading  screen
          ref.listen<bool>(
            isLoadingProvider,
            (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                );
              } else {
                LoadingScreen.instance().hide();
              }
            },
          );
          final isLoggedInUser = ref.watch(isLoggedInProvider);
          if (isLoggedInUser) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

// user already login
class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main View")),
      body: Consumer(
        builder: (_, ref, child) {
          return TextButton(
            onPressed: () async {
              // LoadingScreen.instance().show(context: context, text: "Helloe");
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text("Logout"),
          );
        },
      ),
    );
  }
}

// user not logged in
class LoginView extends ConsumerWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(children: [
        TextButton(
          onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
          child: const Text("Sign In Google"),
        ),
        TextButton(
          onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
          child: const Text("Sign In Facebook"),
        )
      ]),
    );
  }
}
