import 'package:animate_do/animate_do.dart';
import '/app/resources/assets_manager.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/font_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/app/resources/strings_manager.dart';
import '/app/resources/values_manager.dart';

class AboutUSScreen extends StatelessWidget {
  const AboutUSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.aboutUs.tr(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ZoomIn(
                  child: Image(
                    image: CacheHelper.getData(key: SharedKey.isDark) != true
                        ? const AssetImage(
                            AssetsManager.logo,
                          )
                        : const AssetImage(
                            AssetsManager.logoWhite,
                          ),
                    width: AppSize.s200.w,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s60,
              ),
              FadeIn(
                child: Text.rich(
                  TextSpan(
                    text: AppStrings.theStoryBehind.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: AppStrings.appName.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorManager.green,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                AppStrings.discoverTheWorldOfCoffeeWonder.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorManager.mintGreen, height: AppSize.s1.h),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s80,
              ),
              ZoomIn(
                child: Text(
                  AppStrings.coffeeWonderIsALeadingBrand.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: FontSizeManager.s16.sp,
                      ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              FadeIn(
                child: Text.rich(
                  TextSpan(
                    text: AppStrings.ourMainGoal.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: AppStrings.appName.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorManager.green,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              ExpandablePanel(
                header: Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorManager.mintGreen,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s60,
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.exploreCoffeeWonder.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSizeManager.s18.sp,
                            ),
                      ),
                    ),
                  ],
                ),
                collapsed: Text(
                  AppStrings.coffeeWonderTakesPrideInItsExtensiveSelection.tr(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                expanded: Text(
                  AppStrings.coffeeWonderTakesPrideInItsExtensiveSelection.tr(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                theme: ExpandableThemeData(
                  hasIcon: true,
                  iconColor: CacheHelper.getData(key: SharedKey.isDark) != true
                      ? ColorManager.primaryColor
                      : ColorManager.white,
                ),
              ),
              ExpandablePanel(
                header: Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorManager.mintGreen,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s60,
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.findYourPerfectBrewCompanion.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSizeManager.s18.sp,
                            ),
                      ),
                    ),
                  ],
                ),
                collapsed: Text(
                  AppStrings.coffeeWonderOffersADiverseRange.tr(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                expanded: Text(
                  AppStrings.coffeeWonderOffersADiverseRange.tr(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  hasIcon: true,
                  iconColor: CacheHelper.getData(key: SharedKey.isDark) != true
                      ? ColorManager.primaryColor
                      : ColorManager.white,
                ),
              ),
              ExpandablePanel(
                header: Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorManager.mintGreen,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s60,
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.craftedForExcellence.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSizeManager.s18.sp,
                            ),
                      ),
                    ),
                  ],
                ),
                collapsed: Text(
                  AppStrings.atCoffeeWonderQuality.tr(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                expanded: Text(
                  AppStrings.atCoffeeWonderQuality.tr(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                theme: ExpandableThemeData(
                  hasIcon: true,
                  iconColor: CacheHelper.getData(key: SharedKey.isDark) != true
                      ? ColorManager.primaryColor
                      : ColorManager.white,
                ),
              ),
              ExpandablePanel(
                header: Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorManager.mintGreen,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s60,
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.customerSatisfaction.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSizeManager.s18.sp,
                            ),
                      ),
                    ),
                  ],
                ),
                collapsed: Text(
                  AppStrings.coffeeWonderPlacesGreatImportance.tr(),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                expanded: Text(
                  AppStrings.coffeeWonderPlacesGreatImportance.tr(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  hasIcon: true,
                  iconColor: CacheHelper.getData(key: SharedKey.isDark) != true
                      ? ColorManager.primaryColor
                      : ColorManager.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              FadeIn(
                child: Text(
                  AppStrings.vision.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorManager.mintGreen,
                      ),
                ),
              ),
              ZoomIn(
                child: Text(
                  AppStrings.ourVision.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              FadeIn(
                child: Text(
                  AppStrings.mission.tr(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorManager.mintGreen,
                      ),
                ),
              ),
              ZoomIn(
                child: Text(
                  AppStrings.ourMission.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              ZoomIn(
                child: Text(
                  AppStrings.whyCoffeeWonders.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    color: ColorManager.mintGreen,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s40,
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.wideRangeOfCoffeeMachines.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    color: ColorManager.mintGreen,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s40,
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.expertGuidance.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    color: ColorManager.mintGreen,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s40,
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.superiorQualityAndDurability.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    color: ColorManager.mintGreen,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / AppSize.s40,
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.exceptionalCustomerService.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              ZoomIn(
                child: Text(
                  AppStrings.branches.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.jeddah.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "+966562589200",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.riyadah.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "+966568119000",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.madinah.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "+966563116170",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.khamisMashet.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "+966562589200",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
