import 'package:coffee_wonders/app/resources/color_manager.dart';
import 'package:coffee_wonders/app/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HandleErrorFromApiWidget extends StatelessWidget {
  const HandleErrorFromApiWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(
          20.w,
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            AppStrings.failedToLoadData.tr(),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.error,
            ),
          ),
        ));
  }
}
