import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(String email, String password);

  Future<Either<Failure, Unit>> register(
      String email, String username, String password, String passwordConfirm);
}
