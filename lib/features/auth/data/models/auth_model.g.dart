// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => _AuthModel(
  status: json['status'] as bool?,
  msg: json['msg'] as String?,
  token: json['token'] as String?,
  result: json['result'] == null
      ? null
      : Result.fromJson(json['result'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthModelToJson(_AuthModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'token': instance.token,
      'result': instance.result,
    };

_Result _$ResultFromJson(Map<String, dynamic> json) => _Result(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ResultToJson(_Result instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'createdAt': instance.createdAt?.toIso8601String(),
};
