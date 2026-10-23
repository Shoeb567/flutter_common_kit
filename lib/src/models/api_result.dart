import '../error_handling/app_error.dart';

/// Sealed class representing either a successful outcome [Success] or an error [Failure].
sealed class ApiResult<T> {
  const ApiResult();

  /// Returns `true` if this instance is a [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns `true` if this instance is a [Failure].
  bool get isFailure => this is Failure<T>;

  /// Returns data if [Success], otherwise `null`.
  T? get dataOrNull => switch (this) {
        Success(data: final d) => d,
        Failure() => null,
      };

  /// Returns [AppError] if [Failure], otherwise `null`.
  AppError? get errorOrNull => switch (this) {
        Success() => null,
        Failure(error: final e) => e,
      };

  /// Pattern matching handler for both outcomes.
  R when<R>({
    required R Function(T data) success,
    required R Function(AppError error) failure,
  }) {
    return switch (this) {
      Success(data: final d) => success(d),
      Failure(error: final e) => failure(e),
    };
  }

  /// Maps the success value using [transform].
  ApiResult<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final d) => Success<R>(transform(d)),
      Failure(error: final e) => Failure<R>(e),
    };
  }
}

/// Represents a successful result containing [data].
final class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);

  @override
  String toString() => 'Success(data: $data)';
}

/// Represents a failed result containing [error].
final class Failure<T> extends ApiResult<T> {
  final AppError error;
  const Failure(this.error);

  @override
  String toString() => 'Failure(error: $error)';
}
