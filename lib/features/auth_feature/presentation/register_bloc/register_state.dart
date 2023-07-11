part of 'register_bloc.dart';


class RegisterState extends Equatable {
  final String email;
  final String username;
  final String password;
  final String passwordConfirm;
  final bool success;
  final String error;
  final bool isLoading;

  const RegisterState({
    this.email = "",
    this.username = "",
    this.password = "",
    this.passwordConfirm = "",
    this.success = false,
    this.error = "",
    this.isLoading = false,
  });

  RegisterState copyWith({
    String? email,
    String? username,
    String? password,
    String? passwordConfirm,
    bool? success,
    String? error,
    bool? isLoading,
  }) {
    return RegisterState(
        email: email ?? this.email,
        username: username ?? this.username,
        password: password ?? this.password,
        passwordConfirm: passwordConfirm ?? this.passwordConfirm,
        success: success ?? this.success,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props =>
      [email, username, password, passwordConfirm, success, error, isLoading];
}
