import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// Specifies that the [arguments] are passed
abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}

/// Specifies that [no arguments] are passed
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
