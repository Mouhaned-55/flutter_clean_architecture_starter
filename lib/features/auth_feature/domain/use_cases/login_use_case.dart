import 'package:dartz/dartz.dart';
import 'package:flutter_authentication_starter/core/errors/failures.dart';
import 'package:flutter_authentication_starter/features/auth_feature/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
