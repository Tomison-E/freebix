// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Registration _$RegistrationFromJson(Map<String, dynamic> json) {
  return _Registration.fromJson(json);
}

/// @nodoc
class _$RegistrationTearOff {
  const _$RegistrationTearOff();

// ignore: unused_element
  _Registration call(String username,
      {@required String firstName,
      @required String lastName,
      @required String email,
      @required String password,
      int level = 0,
      int stage = 1}) {
    return _Registration(
      username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      level: level,
      stage: stage,
    );
  }

// ignore: unused_element
  Registration fromJson(Map<String, Object> json) {
    return Registration.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Registration = _$RegistrationTearOff();

/// @nodoc
mixin _$Registration {
  String get username;
  String get firstName;
  String get lastName;
  String get email;
  String get password;
  int get level;
  int get stage;

  Map<String, dynamic> toJson();
  $RegistrationCopyWith<Registration> get copyWith;
}

/// @nodoc
abstract class $RegistrationCopyWith<$Res> {
  factory $RegistrationCopyWith(
          Registration value, $Res Function(Registration) then) =
      _$RegistrationCopyWithImpl<$Res>;
  $Res call(
      {String username,
      String firstName,
      String lastName,
      String email,
      String password,
      int level,
      int stage});
}

/// @nodoc
class _$RegistrationCopyWithImpl<$Res> implements $RegistrationCopyWith<$Res> {
  _$RegistrationCopyWithImpl(this._value, this._then);

  final Registration _value;
  // ignore: unused_field
  final $Res Function(Registration) _then;

  @override
  $Res call({
    Object username = freezed,
    Object firstName = freezed,
    Object lastName = freezed,
    Object email = freezed,
    Object password = freezed,
    Object level = freezed,
    Object stage = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed ? _value.username : username as String,
      firstName: firstName == freezed ? _value.firstName : firstName as String,
      lastName: lastName == freezed ? _value.lastName : lastName as String,
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      level: level == freezed ? _value.level : level as int,
      stage: stage == freezed ? _value.stage : stage as int,
    ));
  }
}

/// @nodoc
abstract class _$RegistrationCopyWith<$Res>
    implements $RegistrationCopyWith<$Res> {
  factory _$RegistrationCopyWith(
          _Registration value, $Res Function(_Registration) then) =
      __$RegistrationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String username,
      String firstName,
      String lastName,
      String email,
      String password,
      int level,
      int stage});
}

/// @nodoc
class __$RegistrationCopyWithImpl<$Res> extends _$RegistrationCopyWithImpl<$Res>
    implements _$RegistrationCopyWith<$Res> {
  __$RegistrationCopyWithImpl(
      _Registration _value, $Res Function(_Registration) _then)
      : super(_value, (v) => _then(v as _Registration));

  @override
  _Registration get _value => super._value as _Registration;

  @override
  $Res call({
    Object username = freezed,
    Object firstName = freezed,
    Object lastName = freezed,
    Object email = freezed,
    Object password = freezed,
    Object level = freezed,
    Object stage = freezed,
  }) {
    return _then(_Registration(
      username == freezed ? _value.username : username as String,
      firstName: firstName == freezed ? _value.firstName : firstName as String,
      lastName: lastName == freezed ? _value.lastName : lastName as String,
      email: email == freezed ? _value.email : email as String,
      password: password == freezed ? _value.password : password as String,
      level: level == freezed ? _value.level : level as int,
      stage: stage == freezed ? _value.stage : stage as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Registration implements _Registration {
  _$_Registration(this.username,
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.password,
      this.level = 0,
      this.stage = 1})
      : assert(username != null),
        assert(firstName != null),
        assert(lastName != null),
        assert(email != null),
        assert(password != null),
        assert(level != null),
        assert(stage != null),
        assert(email.isNotEmpty, 'email cannot be empty'),
        assert(
            username.length > 1, 'username should be atleast two characters');

  factory _$_Registration.fromJson(Map<String, dynamic> json) =>
      _$_$_RegistrationFromJson(json);

  @override
  final String username;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @JsonKey(defaultValue: 0)
  @override
  final int level;
  @JsonKey(defaultValue: 1)
  @override
  final int stage;

  bool _didverification = false;
  bool _verification;

  @override
  bool get verification {
    if (_didverification == false) {
      _didverification = true;
      _verification = level == 223344 ? true : false;
    }
    return _verification;
  }

  @override
  String toString() {
    return 'Registration(username: $username, firstName: $firstName, lastName: $lastName, email: $email, password: $password, level: $level, stage: $stage, verification: $verification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Registration &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)) &&
            (identical(other.stage, stage) ||
                const DeepCollectionEquality().equals(other.stage, stage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(level) ^
      const DeepCollectionEquality().hash(stage);

  @override
  _$RegistrationCopyWith<_Registration> get copyWith =>
      __$RegistrationCopyWithImpl<_Registration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RegistrationToJson(this);
  }
}

abstract class _Registration implements Registration {
  factory _Registration(String username,
      {@required String firstName,
      @required String lastName,
      @required String email,
      @required String password,
      int level,
      int stage}) = _$_Registration;

  factory _Registration.fromJson(Map<String, dynamic> json) =
      _$_Registration.fromJson;

  @override
  String get username;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get password;
  @override
  int get level;
  @override
  int get stage;
  @override
  _$RegistrationCopyWith<_Registration> get copyWith;
}
