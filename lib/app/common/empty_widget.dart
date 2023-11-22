import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.empty.tr(),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManager.grey.withOpacity(0.9),
              fontSize: FontSizeManager.s20.sp,
            ),
      ),
    );
  }
}
