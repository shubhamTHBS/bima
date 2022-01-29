import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// General Failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

const String serverFailureMessage = 'serverFailureMessage';
const String cacheFailureMessage = 'cacheFailureMessage';

extension FailureX on Failure {
  String get mapFailureToMessage {
    switch (runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'unexpectedFailureMessage';
    }
  }
}
