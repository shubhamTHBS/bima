import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/sign_out.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignOutUseCase usecase;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignOutUseCase(mockAuthRepository);
  });

  test('should consume signOutUseCase usecase from the repository', () async {
    when(mockAuthRepository.signOut()).thenAnswer((_) async => {});
    await usecase();
    verify(mockAuthRepository.signOut());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
