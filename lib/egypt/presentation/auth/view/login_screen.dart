import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/global/assets_manager.dart';
import '/core/common/app_snack_bars.dart';
import '/core/services/services_locator.dart';
import '/features/auth/data/params.dart';
import '/features/auth/view_model/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/common/widget.dart';
import '/core/global/routes_manager.dart';
import '/core/global/theme/color_manager.dart';
import '/core/global/values_manager.dart';
import '/core/utilities/app_strings.dart';
import '/features/auth/view_model/auth_event.dart';
import '/features/auth/view_model/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  State<LoginScreen> get state => _LoginScreenState();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      create: (context) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            log('login success');
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.layoutRoute,
              (route) => false,
            );
          }
          if (state is AuthLoginFailure) {
            AppSnackBars.showErrorSnackBar(
              context,
              state.message,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                              ? AppStrings.thisFieldIsRequired.tr()
                              : null,
                          context: context,
                          label: AppStrings.emailAddressOrPhonenumber.tr(),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        SharedWidget.defaultTextFormField(
                          textInputType: TextInputType.visiblePassword,
                          label: AppStrings.password.tr(),
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
                              ? AppStrings.thisFieldIsRequired.tr()
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
                              color: ColorManager.primaryColorBlue,
                            ),
                          )
                        else
                          SharedWidget.defaultButton(
                            context: context,
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                return sl<AuthBloc>().add(
                                  AuthLoginEvent(
                                    context: context,
                                    params: LoginParams(
                                        email: _emailController.text,
                                        password: _passwordController.text),
                                  ),
                                );
                              }
                            },
                            text: AppStrings.login.tr(),
                            backgroundColor: ColorManager.primaryColorBlue,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: ColorManager.white,
                                ),
                          ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height / AppSize.s100,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.pushNamed(
                        //       context,
                        //       Routes.forgetPasswordRoute,
                        //     );
                        //   },
                        //   child: Text(
                        //     AppStrings.forgetPassword.tr(),
                        //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //   ),
                        // ),

                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.registerRoute,
                            );
                          },
                          child: Center(
                            child: Text(
                              AppStrings.createAnAccount.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: ColorManager.primaryColorBlue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager
                                        .primaryColorBlue
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
