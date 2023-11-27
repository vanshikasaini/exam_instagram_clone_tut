import 'package:exam_instagram_clone_tut/state/auth/providers/auth_state_provider.dart';
import 'package:exam_instagram_clone_tut/views/components/constants/strings.dart';
import 'package:exam_instagram_clone_tut/views/constants/app_colors.dart';
import 'package:exam_instagram_clone_tut/views/login/divider_with_margins.dart';
import 'package:exam_instagram_clone_tut/views/login/facebook_button.dart';
import 'package:exam_instagram_clone_tut/views/login/google_button.dart';
import 'package:exam_instagram_clone_tut/views/login/login_view_signup_links.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DividerWithMargin(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      height: 1.5,
                    ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed:
                    ref.read(authStateProvider.notifier).loginWithFacebook,
                child: const FacebookButton(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                child: const GoogleButton(),
              ),
              const DividerWithMargin(),
              const LoginViewSignupLink(),
            ],
          ),
        ),
      ),
    );
  }
}
