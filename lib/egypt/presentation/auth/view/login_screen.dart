import 'dart:developer';

import 'package:coffee_wonders/app/resources/strings_manager.dart';
import 'package:coffee_wonders/egypt/data/auth/repo/auth_repo_impl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/common/widget.dart';
import '../../../../app/resources/assets_manager.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../app/resources/routes_manager.dart';
import '../../../../app/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth/params.dart';
import '../view_model/auth_bloc.dart';
import '../view_model/auth_event.dart';
import '../view_model/auth_state.dart';

class EgyptLoginScreen extends StatefulWidget {
  const EgyptLoginScreen({super.key});

  State<EgyptLoginScreen> get state => _EgyptLoginScreenState();

  @override
  State<EgyptLoginScreen> createState() => _EgyptLoginScreenState();
}

class _EgyptLoginScreenState extends State<EgyptLoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isPasswordVisible = true;

  _changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(EgyptAuthRepositoryImpl()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            log('login success');
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.egyptLayoutRoute,
              (route) => false,
            );
          }
          if (state is AuthLoginFailure) {
            SharedWidget.toast(
              message: state.message,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: AppSize.s0,
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AssetsManager.vectorImage,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: MediaQuery.of(context).size.width / AppSize.s10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          AssetsManager.loginTopImage,
                          height:
                              MediaQuery.of(context).size.height / AppSize.s6,
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s20,
                        ),
                        Text(
                          AppStrings.loginDetails.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.sp,
                              ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        SharedWidget.defaultTextFormField(
                          textInputType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (p0) => p0!.isEmpty
                              ? AppStrings.thisIsRequired.tr()
                              : null,
                          context: context,
                          hint: AppStrings.email.tr(),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        SharedWidget.defaultTextFormField(
                          textInputType: TextInputType.visiblePassword,
                          hint: AppStrings.password.tr(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _changePasswordVisibility();
                            },
                            icon: _isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          obscure: _isPasswordVisible,
                          controller: _passwordController,
                          validator: (p0) => p0!.isEmpty
                              ? AppStrings.thisIsRequired.tr()
                              : null,
                          context: context,
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        if (state is AuthLoginLoading)
                          const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primaryColor,
                            ),
                          )
                        else
                          SharedWidget.defaultButton(
                            width: MediaQuery.of(context).size.width,
                            label: AppStrings.login.tr(),
                            context: context,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                return AuthBloc(EgyptAuthRepositoryImpl()).add(
                                  AuthLoginEvent(
                                    context: context,
                                    params: LoginParams(
                                        email: _emailController.text,
                                        password: _passwordController.text),
                                  ),
                                );
                              }
                            },
                          ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.egyptRegisterRoute,
                            );
                          },
                          child: Center(
                            child: Text(
                              AppStrings.createAnAccount.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorManager.primaryColor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    decorationColor: ColorManager.primaryColor
                                        .withAlpha(255),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
