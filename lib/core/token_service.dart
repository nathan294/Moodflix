import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TokenService {
  final FlutterSecureStorage storage;
  final FirebaseAuth firebaseAuth;

  String? _token;

  TokenService(this.storage, this.firebaseAuth) {
    // Listen for auth state changes to refresh token
    firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user != null) {
      _token = await user.getIdToken(true);
      await storage.write(key: 'firebase_token', value: _token);
    } else {
      // Handle user logout: Clear token
      await storage.delete(key: 'firebase_token');
      _token = null;
    }
  }

  Future<String?> getToken() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      _token = await user.getIdToken(true);
      return _token;
    }
    return null;
  }
}
