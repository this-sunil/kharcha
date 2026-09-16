import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
abstract class AuthModel with _$AuthModel {
  const factory AuthModel({
    bool? status,
    String? msg,
    String? token,
    Result? result,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
}

@freezed
abstract class Result with _$Result {
  const factory Result({
    int? id,
    String? name,
    String? phone,
    DateTime? createdAt,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
