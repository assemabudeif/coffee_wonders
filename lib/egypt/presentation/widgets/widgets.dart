import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../brand_products/view/egypt_products_screen.dart';

Widget brandItem({
  required BuildContext context,
  required String label,
  required String image,
  required int id,
  required String brandName,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EgyptProductsScreen(
            id: id,
            branName: brandName,
          ),
        ),
      );
    },
    child: Row(
      children: [
        Container(
          height: AppSize.s100.h,
          width: AppSize.s100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSize.s6,
            ),
            border: Border.all(
              color: CacheHelper.getData(key: SharedKey.isDark) == true
                  ? ColorManager.white
                  : ColorManager.primaryColor,
            ),
            color: CacheHelper.getData(key: SharedKey.isDark) == true
                ? ColorManager.primaryColor
                : ColorManager.white,
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              color: ColorManager.error,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / AppSize.s40,
        ),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
  );
}
