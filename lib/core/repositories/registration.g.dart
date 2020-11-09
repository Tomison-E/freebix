// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Registration _$_$_RegistrationFromJson(Map<String, dynamic> json) {
  return _$_Registration(
    json['username'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    level: json['level'] as int ?? 0,
    stage: json['stage'] as int ?? 1,
  );
}

Map<String, dynamic> _$_$_RegistrationToJson(_$_Registration instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'level': instance.level,
      'stage': instance.stage,
    };
