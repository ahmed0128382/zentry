import 'package:dartz/dartz.dart';
import 'package:zentry/src/shared/domain/errors/failure.dart';

typedef Result<T> = Either<Failure, T>;
