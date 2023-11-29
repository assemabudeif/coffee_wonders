import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class RegistrationParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;

  const RegistrationParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'phone': phone,
      };

  @override
  List<Object> get props => [
        name,
        email,
        password,
        passwordConfirmation,
        phone,
      ];
}
