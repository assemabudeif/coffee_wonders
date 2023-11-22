import '../../egypt/data/products/models/egypt_product_model.dart';
import '../../egypt/presentation/product_details/view/egypt_product_details_screen.dart';
import '../../saudi/model/product_model.dart';
import '../../saudi/presentation/product_details/view/product_details_screen.dart';
import '/app/resources/assets_manager.dart';
import '/app/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class SharedWidget {
  static Widget defaultButton({
    required String label,
    required BuildContext context,
    required double width,
    required Function() onPressed,
    double height = AppSize.s40,
    double raidus = AppSize.s8,
  }) =>
      Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(
            raidus,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: MaterialButton(
          color: ColorManager.mintGreen,
          onPressed: onPressed,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.white,
                ),
          ),
        ),
      );

  static Widget defaultTextFormField({
    required TextEditingController controller,
    required TextInputType textInputType,
    required BuildContext context,
    bool obscure = false,
    String? Function(String?)? validator,
    void Function(String)? onFieldSubmitted,
    Function()? onTap,
    Function(String value)? onChanged,
    String? hint,
    Widget? suffixIcon,
    Widget? prefixIcon,
    int maxLines = 1,
  }) =>
      TextFormField(
        onTap: onTap,
        style: Theme.of(context).textTheme.bodyMedium,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscure,
        onChanged: onChanged,
        cursorColor: ColorManager.mintGreen,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsetsDirectional.only(
            start: MediaQuery.of(context).size.width / AppSize.s16,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
      );

  static Widget productItem({
    required BuildContext context,
    required ProductDataModel model,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              price: model.salePrice,
              id: model.id,
              name: model.name,
              image: model.image,
              quantity: model.quantity,
              categoryName: model.categoryName,
            ),
          ),
        );
      },
      child: SizedBox(
        width: AppSize.s200.w,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    image: model.image.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              model.image,
                            ),
                            fit: BoxFit.fill,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                              AssetsManager.noImage,
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                  height: AppSize.s150.w,
                  width: AppSize.s200.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s120,
                    horizontal:
                        MediaQuery.of(context).size.width / AppSize.s40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.green,
                          fontSize: FontSizeManager.s18.sp),
                    ),
                    Text(
                      "${model.salePrice}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: FontSizeManager.s18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      AppStrings.priceWithoutTax.tr(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: FontSizeManager.s14.sp,
                            color: ColorManager.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget egyptProductItem({
    required BuildContext context,
    required EgyptProductDataModel model,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EgyptProductDetailsScreen(
              price: model.price.toDouble(),
              id: model.id,
              name: model.name,
              image: model.photo,
              quantity: model.stock.toDouble(),
              categoryName: '',
            ),
          ),
        );
      },
      child: SizedBox(
        width: AppSize.s200.w,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    image: model.photo.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              model.photo,
                            ),
                            fit: BoxFit.fill,
                          )
                        : const DecorationImage(
                            image: AssetImage(
                              AssetsManager.noImage,
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                  height: AppSize.s150.w,
                  width: AppSize.s200.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s120,
                    horizontal:
                        MediaQuery.of(context).size.width / AppSize.s40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.green,
                          fontSize: FontSizeManager.s18.sp),
                    ),
                    Text(
                      "${model.price}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: FontSizeManager.s18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      AppStrings.priceWithoutTax.tr(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: FontSizeManager.s14.sp,
                            color: ColorManager.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static toast({required String message, required Color backgroundColor}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: ColorManager.white,
      fontSize: FontSizeManager.s14.sp,
    );
  }
}
