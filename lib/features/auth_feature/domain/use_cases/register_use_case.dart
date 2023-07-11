import 'package:dartz/dartz.dart';
import 'package:flutter_authentication_starter/core/errors/failures.dart';
import 'package:flutter_authentication_starter/features/auth_feature/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call(String email, String username,
      String password, String passwordConfirm) async {
    return await authRepository.register(
        email, username, password, passwordConfirm);
  }
}
