import 'package:coffee_wonders/app/resources/constants_manager.dart';
import 'package:coffee_wonders/app/services/shared_prefrences/cache_helper.dart';
import 'package:coffee_wonders/global/choose_country/choose_country_screen.dart';

import '/global/splash_screen/controller/bloc.dart';
import '../controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AppConstants.egyptToken =
        CacheHelper.getData(key: SharedKey.egyptToken) ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..loginToApi(),
      child: BlocConsumer<SplashBloc, SplashStates>(listener: (context, state) {
        if (state is LoginApiSucessState) {
          // Navigator.pushReplacementNamed(
          //   context,
          //   Routes.layoutRoute,
          // );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ChooseCountryScreen(),
            ),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SizedBox(
            child: Center(
              child: Image(
                width: AppSize.s250.w,
                image: const AssetImage(
                  AssetsManager.logo,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
