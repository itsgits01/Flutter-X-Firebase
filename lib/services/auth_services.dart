import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    // Sign out from Google if the user is already signed in
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    // Begin the interactive sign-in process
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    if (gUser == null) {
      // User cancelled the sign-in process
      return null;
    }

    // Obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credentials
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally, sign in with Firebase
    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}

