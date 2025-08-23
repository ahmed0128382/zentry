// File: lib/src/shared/infrastructure/errors/error_mapper.dart
import 'dart:async';
import 'dart:io';
import 'package:zentry/src/shared/domain/errors/failure.dart';
import 'package:sqlite3/sqlite3.dart' as sql; // drift/native uses sqlite3

Failure mapToFailure(Object error, StackTrace? st) {
  if (error is Failure) return error;

  // Network-ish
  if (error is SocketException) {
    return NetworkFailure(message: error.message, cause: error, stackTrace: st);
  }
  if (error is TimeoutException) {
    return NetworkFailure(
        message: 'Request timeout', cause: error, stackTrace: st);
  }

  // Database / Drift (sqlite3)
  if (error is sql.SqliteException) {
    // You can branch on resultCode/extendedResultCode if you want
    final code = 'SQLITE_${error.resultCode}';
    final isNotFound = false; // sqlite doesn't "not found" by code for selects
    final isConflict = error.resultCode == sql.SqlError.SQLITE_CONSTRAINT;

    if (isConflict) {
      return ConflictFailure(
        message: error.message,
        code: code,
        cause: error,
        stackTrace: st,
      );
    }
    if (isNotFound) {
      return NotFoundFailure(
        message: error.message,
        code: code,
        cause: error,
        stackTrace: st,
      );
    }
    return DatabaseFailure(
      message: error.message,
      code: code,
      cause: error,
      stackTrace: st,
    );
  }

  // Parsing
  if (error is FormatException) {
    return SerializationFailure(
      message: error.message,
      cause: error,
      stackTrace: st,
    );
  }

  // Fallback
  return UnknownFailure(
      message: error.toString(), cause: error, stackTrace: st);
}
