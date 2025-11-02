import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call(String email, String password) async {
    try {
      return await repository.login(email, password);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }
}
