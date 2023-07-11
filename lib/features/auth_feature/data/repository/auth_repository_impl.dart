import 'package:dartz/dartz.dart';
import 'package:flutter_authentication_starter/core/errors/exception.dart';
import 'package:flutter_authentication_starter/core/errors/failures.dart';
import 'package:flutter_authentication_starter/features/auth_feature/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_authentication_starter/features/auth_feature/domain/repositories/auth_repository.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/utils/pref_utils.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final PrefUtils prefUtils;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.prefUtils,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.login(email, password);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> register(String email, String username,
      String password, String passwordConfirm) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.register(
            email, username, password, passwordConfirm);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
