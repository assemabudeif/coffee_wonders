import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../data/params.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  const AuthLoginEvent({
    required this.params,
    required this.context,
  });

  final LoginParams params;
  final BuildContext context;

  @override
  List<Object> get props => [params, context];
}

class AuthRegisterEvent extends AuthEvent {
  final BuildContext context;

  const AuthRegisterEvent({required this.params, required this.context});
  final RegistrationParams params;

  @override
  List<Object> get props => [params, context];
}

class AuthLogoutEvent extends AuthEvent {
  final BuildContext context;
  const AuthLogoutEvent({required this.context});

  @override
  List<Object> get props => [context];
}
