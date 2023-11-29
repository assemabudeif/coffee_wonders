import 'dart:async';

import '/core/utilities/app_constance.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../core/common/app_snack_bars.dart';
import '../../../core/global/routes_manager.dart';
import '/core/network/api_constant.dart';
import '/core/services/services_locator.dart';
import '/core/services/shared_preferences/shared_key.dart';
import '/features/auth/data/repo/auth_repo.dart';
import '/features/auth/data/params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLoginEvent>(onLoginEvent);

    on<AuthRegisterEvent>(onRegisterEvent);

    on<AuthLogoutEvent>(onLogoutEvent);
  }

  FutureOr<void> onLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    final result = await _authRepository.login(
      LoginParams(
        email: event.params.email,
        password: event.params.password,
      ),
    );

    result.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          event.context,
          failure.message,
        );
        emit(AuthLoginFailure(failure.message));
      },
      (success) {
        _saveTokenToSharedPref(
          userId: success.data.user.id.toString(),
          token: success.data.token,
          clientId: success.data.user.user.clientId.toString(),
          profileName: success.data.user.name,
        );
        Navigator.pushNamedAndRemoveUntil(
          event.context,
          Routes.layoutRoute,
          (route) => false,
        );
        emit(AuthLoginSuccess());
      },
    );
  }

  FutureOr<void> onRegisterEvent(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthRegisterLoading());
    final result = await _authRepository.registration(
      RegistrationParams(
        name: event.params.name,
        email: event.params.email,
        password: event.params.password,
        passwordConfirmation: event.params.passwordConfirmation,
        phone: event.params.phone,
      ),
    );
    result.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          event.context,
          failure.message,
        );
        emit(AuthRegisterFailure(failure.message));
      },
      (success) {
        _saveTokenToSharedPref(
          token: success.data.token,
          userId: success.data.user.id.toString(),
          clientId: success.data.user.user.clientId.toString(),
          profileName: success.data.user.name,
        );
        Navigator.pushNamedAndRemoveUntil(
          event.context,
          Routes.layoutRoute,
          (route) => false,
        );
        emit(AuthRegisterSuccess());
      },
    );
  }

  Future<FutureOr<void>> onLogoutEvent(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLogoutLoading());
    final result = await _authRepository.logout();
    result.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          event.context,
          failure.message,
        );
        emit(AuthLogoutFailure(failure.message));
      },
      (success) {
        _removeTokenFromSharedPref();
        Phoenix.rebirth(event.context);
        emit(AuthLogoutSuccess());
      },
    );
  }

  _saveTokenToSharedPref({
    required String token,
    required String clientId,
    required String userId,
    required String profileName,
  }) async {
    ApiConstant.token = token;
    ApiConstant.clientId = clientId;
    AppConstants.profileName = profileName;
    ApiConstant.userId = userId;

    await sl<SharedPreferences>().setString(SharedKey.token.name, token);
    await sl<SharedPreferences>().setString(SharedKey.clientId.name, clientId);
    await sl<SharedPreferences>().setString(SharedKey.userId.name, userId);
    await sl<SharedPreferences>()
        .setString(SharedKey.profileName.name, profileName);
  }

  _removeTokenFromSharedPref() async {
    ApiConstant.token = '';
    ApiConstant.clientId = '';
    ApiConstant.userId = '';
    AppConstants.profileName = '';

    await sl<SharedPreferences>().remove(SharedKey.token.name);
    await sl<SharedPreferences>().remove(SharedKey.clientId.name);
    await sl<SharedPreferences>().remove(SharedKey.userId.name);
    await sl<SharedPreferences>().remove(SharedKey.profileName.name);
  }
}
