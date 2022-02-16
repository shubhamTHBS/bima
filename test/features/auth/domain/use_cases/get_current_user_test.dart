import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/get_current_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bima/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCurrentUser usecase;
  late AuthenticationEntity user;

  setUpAll(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetCurrentUser(mockAuthRepository);
    user = const AuthenticationEntity(phoneNumber: '1234567890');
  });

  test('should consume getCurrentUser usecase from the repository', () async {
    when(mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => user.phoneNumber);
    var result = await usecase();
    expect(result, user.phoneNumber);
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
