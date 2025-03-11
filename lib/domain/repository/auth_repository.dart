abstract class AuthRepository {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String fullName, String email, String password);
  Future<void> signOut();
}
