import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(String email, String password, String name) async {
    try {
      return await repository.register(email, password, name);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }
}
