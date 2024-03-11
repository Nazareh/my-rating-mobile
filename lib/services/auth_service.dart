import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
  //Google sign in
  static signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //sign in!
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static createUserWithEmailAndPassword(String email, String password, String displayName) async {
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    var user = FirebaseAuth.instance.currentUser!;
    user.updateDisplayName(displayName);
    user.sendEmailVerification();

  }
}