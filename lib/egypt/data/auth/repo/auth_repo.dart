import '/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../models/auth_model.dart';
import '../params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login(LoginParams params);
  Future<Either<Failure, AuthModel>> registration(RegistrationParams params);
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, String>> deleteClientAccount();

  Future<Either<Failure, String>> updateFCMToken(String token);
}
