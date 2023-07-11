part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool success;
  final String error;
  final bool isLoading;

  const LoginState({
    this.email = "",
    this.password = "",
    this.success = false,
    this.error = "",
    this.isLoading = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? success,
    String? error,
    bool? isLoading,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        success: success ?? this.success,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [email, password, success, error, isLoading];
}
