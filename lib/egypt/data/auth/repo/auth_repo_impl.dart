import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/services/services_locator.dart';
import '/core/services/shared_preferences/shared_key.dart';
import '/core/utilities/app_constance.dart';
import '/core/error/failures.dart';
import '/features/auth/data/models/auth_model.dart';
import '/features/auth/data/params.dart';
import '/core/network/api_constant.dart';
import '/core/services/dio_helper/dio_helper.dart';
import 'auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, AuthModel>> registration(
      RegistrationParams params) async {
    try {
      final response = await sl<DioHelper>().postData(
        path: ApiConstant.registerPath,
        data: params.toJson(),
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        return Right(AuthModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['message']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['message']));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> login(LoginParams params) async {
    try {
      final response = await sl<DioHelper>().postData(
        path: ApiConstant.loginPath,
        data: params.toJson(),
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        return Right(AuthModel.fromJson(response.data));
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
      final response = await sl<DioHelper>().getData(
        path: ApiConstant.logoutPath,
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

  @override
  Future<Either<Failure, String>> deleteClientAccount() async {
    try {
      final response = await sl<DioHelper>().delData(
        path: ApiConstant.deleteClientAccountPath,
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        _removeTokenFromSharedPref();
        return const Right('Deleted Account Successfully');
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

  @override
  Future<Either<Failure, String>> updateFCMToken(String token) async {
    try {
      final response = await sl<DioHelper>().postData(
        path: ApiConstant.updateFCMTokenPath,
        data: {
          "fcm_token": token,
        },
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        return const Right('FCM Token Updated Successfully');
      } else {
        return Left(ServerFailure(response.data?['message'] ?? 'Error'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Error'));
    }
  }

  _removeTokenFromSharedPref() async {
    ApiConstant.token = '';
    ApiConstant.clientId = '';
    AppConstants.profileName = '';

    await sl<SharedPreferences>().remove(SharedKey.profileName.name);
    await sl<SharedPreferences>().remove(SharedKey.token.name);
    await sl<SharedPreferences>().remove(SharedKey.clientId.name);
  }
}
