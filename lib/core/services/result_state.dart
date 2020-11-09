import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exceptions.dart';

part 'result_state.freezed.dart';

@freezed
abstract class ResultState<T> with _$ResultState<T> {
  ResultState._();
  factory ResultState.data(T value) = _ResultData<T>;
  factory ResultState.error(NetworkExceptions error, [StackTrace stackTrace]) = _ResultError<T>;

  factory ResultState.guard(T Function() cb) {
    try {
      return ResultState.data(cb());
    } catch (err, stack) {
      return ResultState.error(err, stack);
    }
  }

  static Future<ResultState<T>> guardFuture<T>(Future<T> Function() cb) async {
    try {
      return ResultState.data(await cb());
    } catch (err, stack) {
      return ResultState.error(err, stack);
    }
  }

  ResultState<Res> chain<Res>(Res Function(T value) cb) {
    return when(
      data: (value) {
        try {
          return ResultState.data(cb(value));
        } catch (err, stack) {
          return ResultState.error(err, stack);
        }
      },
      error: (err, stack) => ResultState.error(err, stack),
    );
  }

  T get dataOrThrow {
    return when(
      data: (value) => value,
      error: (err, stack) {
        // ignore: only_throw_errors
        throw err;
      },
    );
  }
}