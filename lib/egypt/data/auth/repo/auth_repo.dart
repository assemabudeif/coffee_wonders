import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../models/egypt_login_model.dart';
import '../models/egypt_register_model.dart';
import '../params.dart';

abstract class EgyptAuthRepository {
  Future<Either<Failure, EgyptLoginModel>> login(LoginParams params);
  Future<Either<Failure, EgyptRegisterModel>> registration(
      RegistrationParams params);
  Future<Either<Failure, String>> logout();
}
