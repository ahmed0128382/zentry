// File: lib/src/shared/infrastructure/utils/guard.dart
import 'package:dartz/dartz.dart';
import 'package:zentry/src/shared/domain/errors/failure.dart';
import 'package:zentry/src/shared/infrastructure/errors/error_mapper.dart';

typedef Result<T> = Either<Failure, T>;

Future<Result<T>> guard<T>(Future<T> Function() run) async {
  try {
    return Right(await run());
  } catch (e, st) {
    return Left(mapToFailure(e, st));
  }
}

Result<T> guardSync<T>(T Function() run) {
  try {
    return Right(run());
  } catch (e, st) {
    return Left(mapToFailure(e, st));
  }
}
