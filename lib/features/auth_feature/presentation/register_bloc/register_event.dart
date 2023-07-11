part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String email;
  final String username;
  final String password;
  final String passwordConfirm;


  const RegisterUserEvent(this.email,this.username, this.password,this.passwordConfirm);

  @override
  List<Object> get props => [email,username, password,passwordConfirm];
}
