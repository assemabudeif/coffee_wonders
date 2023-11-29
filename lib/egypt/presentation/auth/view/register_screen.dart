import '../../../core/global/assets_manager.dart';
import '/core/global/routes_manager.dart';
import '/features/auth/data/params.dart';
import '/features/auth/view_model/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/app_snack_bars.dart';
import '../../../core/common/widget.dart';
import '../../../core/global/theme/color_manager.dart';
import '../../../core/global/values_manager.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utilities/app_strings.dart';
import '../view_model/auth_event.dart';
import '../view_model/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  _changePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _changeConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginRoute,
              (_) => false,
            );
          }

          if (state is AuthRegisterFailure) {
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
              title: Text(
                AppStrings.createAnAccount.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s50,
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s10,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                          SharedWidget.defaultTextFormField(
                            label: AppStrings.name.tr(),
                            textInputType: TextInputType.text,
                            context: context,
                            controller: _nameController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisFieldIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            label: AppStrings.email.tr(),
                            textInputType: TextInputType.emailAddress,
                            context: context,
                            controller: _emailController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisFieldIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            label: AppStrings.password.tr(),
                            textInputType: TextInputType.visiblePassword,
                            context: context,
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
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            label: AppStrings.confirmPassword.tr(),
                            textInputType: TextInputType.visiblePassword,
                            context: context,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _changeConfirmPasswordVisibility();
                              },
                              icon: _isConfirmPasswordVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            obscure: _isConfirmPasswordVisible,
                            controller: _confirmPasswordController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisFieldIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            label: AppStrings.phoneNumber.tr(),
                            textInputType: TextInputType.number,
                            context: context,
                            controller: _phoneNumberController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisFieldIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            label: AppStrings.address.tr(),
                            textInputType: TextInputType.streetAddress,
                            context: context,
                            controller: _addressController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisFieldIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s16,
                          ),
                          if (state is AuthRegisterLoading)
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
                                  sl<AuthBloc>().add(
                                    AuthRegisterEvent(
                                      context: context,
                                      params: RegistrationParams(
                                        email: _emailController.text,
                                        name: _nameController.text,
                                        password: _passwordController.text,
                                        passwordConfirmation:
                                            _confirmPasswordController.text,
                                        phone: _phoneNumberController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              text: AppStrings.signUp.tr(),
                              backgroundColor: ColorManager.primaryColorBlue,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: ColorManager.white,
                                  ),
                            ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s50,
                          ),
                        ],
                      ),
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
