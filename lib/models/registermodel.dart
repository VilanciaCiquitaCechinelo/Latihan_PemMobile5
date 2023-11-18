// auth_model.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        User? firebaseUser = userCredential.user;
        await _updateUserDetails(firebaseUser!, email);
        return firebaseUser;
      }
    } catch (e) {
      print('Registrasi gagal: $e');
    }
    return null;
  }

  Future<void> _updateUserDetails(User firebaseUser, String email) async {
    await firebaseUser.updateDisplayName('');
    await firebaseUser.reload();
    await firebaseUser.updateEmail(email);
  }
}