abstract class AuthRepository {
  Future<void> signIn(String email, String password);
  Future<void> signUp(Object? data);
  Future<void> refreshToken();
  Future<void> signOut();
}
