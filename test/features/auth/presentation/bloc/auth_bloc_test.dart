import 'package:bima/core/error/failure.dart';
import 'package:bima/core/usecases/usecases.dart';
import 'package:bima/features/auth/domain/entities/auth.dart';
import 'package:bima/features/auth/domain/use_cases/get_current_user.dart';
import 'package:bima/features/auth/domain/use_cases/sign_in_with_phone_number.dart';
import 'package:bima/features/auth/domain/use_cases/sign_out.dart';
import 'package:bima/features/auth/domain/use_cases/verify_sms_code.dart';
import 'package:bima/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SignInWithPhoneNumber>(
      as: #MockSignInWithPhoneNumber, returnNullOnMissingStub: true),
  MockSpec<VerifySmsCode>(
      as: #MockVerifySmsCode, returnNullOnMissingStub: true),
  MockSpec<GetCurrentUser>(
      as: #MockGetCurrentUser, returnNullOnMissingStub: true),
  MockSpec<SignOutUseCase>(
      as: #MockSignOutUseCase, returnNullOnMissingStub: true),
])
void main() {
  late AuthBloc bloc;
  late MockSignInWithPhoneNumber mockSignInWithPhoneNumber;
  late MockVerifySmsCode mockVerifySmsCode;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockSignOutUseCase mockSignOutUseCase;

  setUp(() {
    mockSignInWithPhoneNumber = MockSignInWithPhoneNumber();
    mockVerifySmsCode = MockVerifySmsCode();
    mockGetCurrentUser = MockGetCurrentUser();
    mockSignOutUseCase = MockSignOutUseCase();
    bloc = AuthBloc(
      signInWithPhoneNumber: mockSignInWithPhoneNumber,
      verifySmsCode: mockVerifySmsCode,
      signOutUseCase: mockSignOutUseCase,
      getCurrentUser: mockGetCurrentUser,
    );
  });

  const user = AuthenticationEntity(phoneNumber: '1234567890');

  test('Initial state should be AuthInitialState', () {
    // Assert
    expect(bloc.state, AuthInitialState());
  });

  test(
      'should emit [AuthLoadingState], [AuthLoggedInState] when the code is verified successfully',
      () {
    // Arrange
    when(mockVerifySmsCode(any)).thenAnswer((_) async => user);
    // Assert later
    final expected = [
      AuthLoadingState(),
      const AuthLoggedInState(user),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));
    // Act
    bloc.add(const PhoneAuthCodeVerified(smsCode: '123456'));
  });

  test('should emit [AuthLoggedOutState] when SignOut event is triggered', () {
    // Arrange
    when(mockSignOutUseCase()).thenAnswer((_) async => true);
    // Assert later
    final expected = [
      AuthLoggedOutState(),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));
    // Act
    bloc.add(SignOut());
  });

  test('should emit [AuthLoggedInState] when getCurrentUser event is triggered',
      () {
    // Arrange
    when(mockGetCurrentUser()).thenAnswer((_) async => user.phoneNumber);
    // Assert later
    final expected = [
      const AuthLoggedInState(user),
    ];
    expectLater(bloc.stream, emitsInOrder(expected));
    // Act
    bloc.add(PhoneAuthCurrentUser());
  });
}
