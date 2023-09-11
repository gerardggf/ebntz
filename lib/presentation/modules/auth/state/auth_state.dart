import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState({
    @Default(false) bool fetching,
    @Default(false) bool isRegister,
    @Default(false) bool acceptPrivacyPolicy,
    @Default('') String email,
    @Default('') String password,
  }) = _AuthState;
}
