// ignore_for_file: deprecated_member_use

import '/app/constant/saudi_api_constant.dart';
import '/app/services/dio_helper/saudi_dio_helper.dart';
import '../../../saudi/model/login_model.dart';
import '/global/splash_screen/controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/services/shared_prefrences/cache_helper.dart';

class SplashBloc extends Cubit<SplashStates> {
  SplashBloc() : super(SplashInitState());
  static SplashBloc get(context) => BlocProvider.of(context);
  LoginModel loginModel = LoginModel();
  void loginToApi() {
    emit(LoginApiLoadingState());
    SaudiDioHelper.postData(
      path: SaudiApiConstant.loginPath,
      data: {
        "login": "coffee",
        "password": "bDZ8IdZCYvYbA9f7",
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      CacheHelper.setData(
        key: SharedKey.token,
        value: loginModel.result.data.token,
      );
      emit(
        LoginApiSucessState(),
      );
    }).catchError((error) {
      emit(LoginApiErrorState());
    });
  }
}
