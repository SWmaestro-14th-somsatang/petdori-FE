import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginService {
  static Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      String? accessToken = googleAuth.accessToken;
      print(accessToken);
    }
  }
}
