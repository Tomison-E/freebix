// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ResultStateTearOff {
  const _$ResultStateTearOff();

// ignore: unused_element
  _ResultData<T> data<T>(T value) {
    return _ResultData<T>(
      value,
    );
  }

// ignore: unused_element
  _ResultError<T> error<T>(NetworkExceptions error, [StackTrace stackTrace]) {
    return _ResultError<T>(
      error,
      stackTrace,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ResultState = _$ResultStateTearOff();

/// @nodoc
mixin _$ResultState<T> {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result data(T value),
    @required Result error(NetworkExceptions error, StackTrace stackTrace),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result data(T value),
    Result error(NetworkExceptions error, StackTrace stackTrace),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result data(_ResultData<T> value),
    @required Result error(_ResultError<T> value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result data(_ResultData<T> value),
    Result error(_ResultError<T> value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $ResultStateCopyWith<T, $Res> {
  factory $ResultStateCopyWith(
          ResultState<T> value, $Res Function(ResultState<T>) then) =
      _$ResultStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ResultStateCopyWithImpl<T, $Res>
    implements $ResultStateCopyWith<T, $Res> {
  _$ResultStateCopyWithImpl(this._value, this._then);

  final ResultState<T> _value;
  // ignore: unused_field
  final $Res Function(ResultState<T>) _then;
}

/// @nodoc
abstract class _$ResultDataCopyWith<T, $Res> {
  factory _$ResultDataCopyWith(
          _ResultData<T> value, $Res Function(_ResultData<T>) then) =
      __$ResultDataCopyWithImpl<T, $Res>;
  $Res call({T value});
}

/// @nodoc
class __$ResultDataCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res>
    implements _$ResultDataCopyWith<T, $Res> {
  __$ResultDataCopyWithImpl(
      _ResultData<T> _value, $Res Function(_ResultData<T>) _then)
      : super(_value, (v) => _then(v as _ResultData<T>));

  @override
  _ResultData<T> get _value => super._value as _ResultData<T>;

  @override
  $Res call({
    Object value = freezed,
  }) {
    return _then(_ResultData<T>(
      value == freezed ? _value.value : value as T,
    ));
  }
}

/// @nodoc
class _$_ResultData<T> extends _ResultData<T> {
  _$_ResultData(this.value)
      : assert(value != null),
        super._();

  @override
  final T value;

  @override
  String toString() {
    return 'ResultState<$T>.data(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ResultData<T> &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  _$ResultDataCopyWith<T, _ResultData<T>> get copyWith =>
      __$ResultDataCopyWithImpl<T, _ResultData<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result data(T value),
    @required Result error(NetworkExceptions error, StackTrace stackTrace),
  }) {
    assert(data != null);
    assert(error != null);
    return data(value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result data(T value),
    Result error(NetworkExceptions error, StackTrace stackTrace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (data != null) {
      return data(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result data(_ResultData<T> value),
    @required Result error(_ResultError<T> value),
  }) {
    assert(data != null);
    assert(error != null);
    return data(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result data(_ResultData<T> value),
    Result error(_ResultError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ResultData<T> extends ResultState<T> {
  _ResultData._() : super._();
  factory _ResultData(T value) = _$_ResultData<T>;

  T get value;
  _$ResultDataCopyWith<T, _ResultData<T>> get copyWith;
}

/// @nodoc
abstract class _$ResultErrorCopyWith<T, $Res> {
  factory _$ResultErrorCopyWith(
          _ResultError<T> value, $Res Function(_ResultError<T>) then) =
      __$ResultErrorCopyWithImpl<T, $Res>;
  $Res call({NetworkExceptions error, StackTrace stackTrace});

  $NetworkExceptionsCopyWith<$Res> get error;
}

/// @nodoc
class __$ResultErrorCopyWithImpl<T, $Res>
    extends _$ResultStateCopyWithImpl<T, $Res>
    implements _$ResultErrorCopyWith<T, $Res> {
  __$ResultErrorCopyWithImpl(
      _ResultError<T> _value, $Res Function(_ResultError<T>) _then)
      : super(_value, (v) => _then(v as _ResultError<T>));

  @override
  _ResultError<T> get _value => super._value as _ResultError<T>;

  @override
  $Res call({
    Object error = freezed,
    Object stackTrace = freezed,
  }) {
    return _then(_ResultError<T>(
      error == freezed ? _value.error : error as NetworkExceptions,
      stackTrace == freezed ? _value.stackTrace : stackTrace as StackTrace,
    ));
  }

  @override
  $NetworkExceptionsCopyWith<$Res> get error {
    if (_value.error == null) {
      return null;
    }
    return $NetworkExceptionsCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc
class _$_ResultError<T> extends _ResultError<T> {
  _$_ResultError(this.error, [this.stackTrace])
      : assert(error != null),
        super._();

  @override
  final NetworkExceptions error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ResultState<$T>.error(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ResultError<T> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.stackTrace, stackTrace) ||
                const DeepCollectionEquality()
                    .equals(other.stackTrace, stackTrace)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(stackTrace);

  @override
  _$ResultErrorCopyWith<T, _ResultError<T>> get copyWith =>
      __$ResultErrorCopyWithImpl<T, _ResultError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result data(T value),
    @required Result error(NetworkExceptions error, StackTrace stackTrace),
  }) {
    assert(data != null);
    assert(error != null);
    return error(this.error, stackTrace);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result data(T value),
    Result error(NetworkExceptions error, StackTrace stackTrace),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this.error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result data(_ResultData<T> value),
    @required Result error(_ResultError<T> value),
  }) {
    assert(data != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result data(_ResultData<T> value),
    Result error(_ResultError<T> value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ResultError<T> extends ResultState<T> {
  _ResultError._() : super._();
  factory _ResultError(NetworkExceptions error, [StackTrace stackTrace]) =
      _$_ResultError<T>;

  NetworkExceptions get error;
  StackTrace get stackTrace;
  _$ResultErrorCopyWith<T, _ResultError<T>> get copyWith;
}
