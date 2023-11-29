import 'package:coffee_wonders/app/resources/strings_manager.dart';
import 'package:coffee_wonders/app/services/shared_prefrences/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/resources/assets_manager.dart';
import '../../app/resources/routes_manager.dart';
import '../../egypt/presentation/layout/view/egypt_layout_screen.dart';

class ChooseCountryScreen extends StatefulWidget {
  const ChooseCountryScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCountryScreen> createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.chooseCountry.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.layoutRoute,
                  (route) => false,
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsManager.saudiFlag,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    AppStrings.saudi.tr(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (CacheHelper.getData(key: SharedKey.egyptToken) != null) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.egyptLayoutRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.egyptLoginRoute,
                    (route) => false,
                  );
                }
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsManager.egyptFlag,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    AppStrings.egypt.tr(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
