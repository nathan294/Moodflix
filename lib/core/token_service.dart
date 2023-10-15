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

      // // Load data for other Blocs
      // homePageBloc.add(home_bloc.LoadDataEvent());
      // profileBloc.add(profile_bloc.LoadDataEvent());
      // collectionBloc.add(collection_bloc.LoadDataEvent());
      // discoverBloc.add(discover_bloc.LoadDataEvent());
    } else {
      // Handle user logout: Clear token
      await storage.delete(key: 'firebase_token');
      _token = null;
    }
  }

  Future<String?> getToken() async {
    _token ??= await storage.read(key: 'firebase_token');
    return _token;
  }
}
