import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_response_model.freezed.dart';
part 'sign_up_response_model.g.dart';

@freezed
abstract class SignUpResponseModel with _$SignUpResponseModel {
  const factory SignUpResponseModel({
    required String id,
    required String email,
  }) = _SignUpResponseModel;

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);
}
