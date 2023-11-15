import 'package:exam_instagram_clone_tut/state/auth/constants/constant.dart';
import 'package:exam_instagram_clone_tut/state/auth/models/auth_result.dart';
import 'package:exam_instagram_clone_tut/state/posts/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Authenticating you with facebook and google login
class Authenticator {
  const Authenticator();
  User? get user => FirebaseAuth.instance.currentUser;
  UserId? get userId => user?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => user?.displayName ?? '';
  String? get email => user?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResults> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    //above method FacebookAuth.instance.login(); --> show facebook sign in dialog

    final token = loginResult.accessToken?.token;
    if (token == null) {
      // user has aborted the logging in process
      return AuthResults.aborted;
    }
    final oauthCredentials = FacebookAuthProvider.credential(token);
    try {
// if looged in with Facebook then must logged in with Firebase also so
// to do this
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResults.success;
    } on FirebaseAuthException catch (e) {
      // if logged in with google and logout then try to login with facebook
      // with same credentials then Firebase will throw error
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(
          email,
        );
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(
            credential,
          );
        }
        return AuthResults.success;
      }
      return AuthResults.failure;
    }
  }

  Future<AuthResults> loginWithGoogle() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: [Constants.emailScope]);

    final signInAccount = await googleSignIn.signIn();
    //above method googleSignIn.signIn(); --> show google sign in dialog
    if (signInAccount == null) {
      return AuthResults.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
// if looged in with Facebook then must logged in with Firebase also so
// to do this
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResults.success;
    } catch (e) {
      return AuthResults.failure;
    }
  }
}
