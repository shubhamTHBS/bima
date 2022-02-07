import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository authRepository;

  GetCurrentUser(this.authRepository);

  Future<String?> call() async {
    return await authRepository.getCurrentUser();
  }
}
