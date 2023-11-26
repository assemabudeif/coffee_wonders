import 'dart:developer';

import 'package:coffee_wonders/app/common/empty_widget.dart';
import 'package:coffee_wonders/app/common/handle_error_from_api_widget.dart';
import 'package:coffee_wonders/app/resources/assets_manager.dart';
import 'package:coffee_wonders/egypt/data/categories/models/egypt_categories_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';
import '../../data/categories/repository/categories_repository_impl.dart';
import '/app/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../brands/view/egypt_brands_screen.dart';
import 'egypt_category_brands_screen.dart';

class EgyptCategoriesScreen extends StatelessWidget {
  const EgyptCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<EgyptCategoriesModel>(
        future: CategoriesRepositoryImpl().getAllCategories(),
        builder: (context, snapshot) {
          log(snapshot.error.toString());
          if (snapshot.hasError) {
            return const HandleErrorFromApiWidget();
          } else if (snapshot.hasData) {
            if (snapshot.data?.data.isNotEmpty ?? false) {
              return ListView.separated(
                itemBuilder: (context, index) => categoryItem(
                  categoryId: snapshot.data!.data[index].id.toString(),
                  context: context,
                  label: snapshot.data!.data[index].name,
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.data.length,
              );
            } else {
              return const EmptyWidget();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget categoryItem({
  required BuildContext context,
  required String label,
  required String categoryId,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EgyptCategoryBrandsScreen(
            title: label,
            categoryId: categoryId,
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
          padding: EdgeInsets.all(
            AppSize.s10.w,
          ),
          child: Image.asset(
            AssetsManager.categoryImage,
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
