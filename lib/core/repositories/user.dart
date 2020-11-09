
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:freebix/core/services/api_result.dart';
import 'package:freebix/core/services/firebase_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


@freezed
abstract class User with _$User {
@Assert('email.isNotEmpty', 'email cannot be empty')
@Assert('username.length>1', 'username should be atleast two characters')

 factory User({@required String firstName, @required String lastName,
@required String email, @required String username,int level, int stage}) = _User;

factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}


class UserRepository extends StateNotifier<User>{
 UserRepository(this._read,[User user]) : super(user ?? null);

 final Reader _read;

 Future<QuerySnapshot> getUser(String email){
   return _read(fireBaseClientProvider).getWhere("users", "email", email);
 }

 Future<ApiResult<bool>> updateLevel(String docID, Object data){
  return _read(fireBaseClientProvider).Update("users", data, docID);
 }

 void refresh(){
   state = User(firstName: " ", lastName: " ", email: " ", username: "ab");
 }



}

// ignore: top_level_function_literal_block
final userRepositoryProvider = StateNotifierProvider((ref) => UserRepository(ref.read));

