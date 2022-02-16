import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future<void>? call() async {
    return await authRepository.signOut();
  }
}
