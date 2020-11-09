
import 'package:flutter_riverpod/all.dart';
import 'package:freebix/core/services/api_result.dart';
import 'package:freebix/core/services/authentication.dart';
import 'package:freebix/core/services/firebase_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration.freezed.dart';
part 'registration.g.dart';


@freezed
abstract class Registration with _$Registration {
@Assert('email.isNotEmpty', 'email cannot be empty')
@Assert('username.length>1', 'username should be atleast two characters')
factory Registration(String username, {@required String firstName, @required String lastName,
                             @required String email, @required String password, @Default(0) int level, @Default(1) int stage}) = _Registration;

factory Registration.fromJson(Map<String, dynamic> json) => _$RegistrationFromJson(json);


@late
bool get verification => level == 223344 ? true : false;

}


class RegistrationRepository extends StateNotifier<Registration>{
  RegistrationRepository(this._read,[Registration register]) : super(register ?? null);

  final Reader _read;

  Future<ApiResult<bool>> register(Registration register) async{
    final createdUser = await _read(authenticationProvider).createUser(register.email, register.password);
   return createdUser.maybeWhen(
        success: (bool data) =>  _read(fireBaseClientProvider).post("users", register.toJson()),
        error: (String errorMsg) => ApiResult.error(errorMsg: errorMsg),
        orElse: () => ApiResult.error(errorMsg: "Unable to register user"),
    );

  }


}

// ignore: top_level_function_literal_block
final registrationRepositoryProvider = StateNotifierProvider((ref) => RegistrationRepository(ref.read));


