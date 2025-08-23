// File: lib/src/shared/domain/errors/failure.dart
import 'package:equatable/equatable.dart';

/// Base type for all domain errors.
sealed class Failure extends Equatable {
  final String message; // Dev/debug message
  final String? code; // Optional error code (e.g. "SQLITE_CONSTRAINT")
  final Object? cause; // Original error (never show to user)
  final StackTrace? stackTrace;

  const Failure({
    required this.message,
    this.code,
    this.cause,
    this.stackTrace,
  });

  /// Localizable, user-friendly message.
  String get userMessage => 'Something went wrong';

  @override
  List<Object?> get props => [message, code];
}

final class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'validation',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => message; // usually safe to show
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code = 'not_found',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'Item not found';
}

final class ConflictFailure extends Failure {
  const ConflictFailure({
    required super.message,
    super.code = 'conflict',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'There is a conflict with existing data';
}

final class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code = 'permission',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'You don\'t have permission to do this';
}

final class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code = 'network',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'Please check your internet connection';
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code = 'database',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'A storage error occurred';
}

final class SerializationFailure extends Failure {
  const SerializationFailure({
    required super.message,
    super.code = 'serialization',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'We could not read this data';
}

final class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code = 'unknown',
    super.cause,
    super.stackTrace,
  });

  @override
  String get userMessage => 'Unexpected error';
}
