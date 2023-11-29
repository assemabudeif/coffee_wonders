import 'dart:async';

import 'package:coffee_wonders/app/common/widget.dart';
import 'package:coffee_wonders/app/resources/constants_manager.dart';
import 'package:coffee_wonders/app/services/shared_prefrences/cache_helper.dart';

import '../../../../app/resources/routes_manager.dart';
import '../../../data/auth/params.dart';
import '../../../data/auth/repo/auth_repo.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final EgyptAuthRepository _authRepository;

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
        SharedWidget.toast(
          message: failure.message,
          backgroundColor: Colors.red,
        );
        emit(AuthLoginFailure(failure.message));
      },
      (success) {
        _saveTokenToSharedPref(
          token: success.data.token,
        );
        Navigator.pushNamedAndRemoveUntil(
          event.context,
          Routes.egyptLayoutRoute,
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
      ),
    );
    result.fold(
      (failure) {
        SharedWidget.toast(
          message: failure.message,
          backgroundColor: Colors.red,
        );
        emit(AuthRegisterFailure(failure.message));
      },
      (success) {
        _saveTokenToSharedPref(
          token: success.data.token,
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
        SharedWidget.toast(
          message: failure.message,
          backgroundColor: Colors.red,
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
  }) async {
    AppConstants.egyptToken = token;

    await CacheHelper.setData(key: SharedKey.egyptToken, value: token);
  }

  _removeTokenFromSharedPref() async {
    AppConstants.egyptToken = '';
    await CacheHelper.removeData(key: SharedKey.egyptToken);
  }
}
