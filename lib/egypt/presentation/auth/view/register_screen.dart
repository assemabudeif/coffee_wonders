import 'package:coffee_wonders/app/common/widget.dart';
import 'package:coffee_wonders/egypt/data/auth/repo/auth_repo_impl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/resources/assets_manager.dart';
import '../../../../app/resources/color_manager.dart';
import '../../../../app/resources/routes_manager.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../app/resources/values_manager.dart';
import '../../../data/auth/params.dart';
import '../view_model/auth_bloc.dart';
import '../view_model/auth_event.dart';
import '../view_model/auth_state.dart';

class EgyptRegisterScreen extends StatefulWidget {
  const EgyptRegisterScreen({super.key});

  @override
  State<EgyptRegisterScreen> createState() => _EgyptRegisterScreenState();
}

class _EgyptRegisterScreenState extends State<EgyptRegisterScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

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
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(EgyptAuthRepositoryImpl()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.egyptLoginRoute,
              (_) => false,
            );
          }

          if (state is AuthRegisterFailure) {
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
              title: Text(
                AppStrings.createAnAccount.tr().replaceAll('?', ''),
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
                            hint: AppStrings.name.tr(),
                            textInputType: TextInputType.text,
                            context: context,
                            controller: _nameController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            hint: AppStrings.email.tr(),
                            textInputType: TextInputType.emailAddress,
                            context: context,
                            controller: _emailController,
                            validator: (p0) => p0!.isEmpty
                                ? AppStrings.thisIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            hint: AppStrings.password.tr(),
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
                                ? AppStrings.thisIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          SharedWidget.defaultTextFormField(
                            hint: AppStrings.confirmPassword.tr(),
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
                                ? AppStrings.thisIsRequired.tr()
                                : null,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s16,
                          ),
                          if (state is AuthRegisterLoading)
                            const Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.primaryColor,
                              ),
                            )
                          else
                            SharedWidget.defaultButton(
                              context: context,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  AuthBloc(EgyptAuthRepositoryImpl()).add(
                                    AuthRegisterEvent(
                                      context: context,
                                      params: RegistrationParams(
                                        email: _emailController.text,
                                        name: _nameController.text,
                                        password: _passwordController.text,
                                        passwordConfirmation:
                                            _confirmPasswordController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              label: AppStrings.signUp.tr(),
                              width: MediaQuery.of(context).size.width,
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
