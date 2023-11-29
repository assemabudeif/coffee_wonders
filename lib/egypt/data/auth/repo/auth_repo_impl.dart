import 'package:coffee_wonders/app/constant/egypt_api_constant.dart';
import 'package:coffee_wonders/app/resources/constants_manager.dart';
import 'package:coffee_wonders/app/services/dio_helper/egypt_dio_helper.dart';
import 'package:coffee_wonders/app/services/shared_prefrences/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../app/error/failures.dart';
import '../models/egypt_login_model.dart';
import '../models/egypt_register_model.dart';
import '../params.dart';
import 'auth_repo.dart';

class EgyptAuthRepositoryImpl extends EgyptAuthRepository {
  @override
  Future<Either<Failure, EgyptRegisterModel>> registration(
      RegistrationParams params) async {
    try {
      final response = await EgyptDioHelper.postData(
        path: EgyptApiConstant.registerPath,
        data: params.toJson(),
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        return Right(EgyptRegisterModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['message']));
    }
  }

  @override
  Future<Either<Failure, EgyptLoginModel>> login(LoginParams params) async {
    try {
      final response = await EgyptDioHelper.postData(
        path: EgyptApiConstant.loginPath,
        data: params.toJson(),
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        return Right(EgyptLoginModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['message']));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.logoutPath,
      );

      if ((response.statusCode == 200 || response.statusCode == 201)) {
        // && response.data["status"] == "success") {
        _removeTokenFromSharedPref();
        return const Right('Logout Success');
      } else {
        if (response.data['message'] == "Unauthenticated.") {
          _removeTokenFromSharedPref();
        }
        return Left(ServerFailure(response.data['message']));
      }
    } on DioException catch (e) {
      if (e.response!.data['message'] == "Unauthenticated.") {
        _removeTokenFromSharedPref();
      }
      return Left(ServerFailure(e.response!.data['message']));
    }
  }

  _removeTokenFromSharedPref() async {
    AppConstants.egyptToken = '';

    await CacheHelper.removeData(key: SharedKey.egyptToken);
  }
}
