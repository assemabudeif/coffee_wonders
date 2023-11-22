// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import '/saudi/presentation/home/controller/bloc.dart';
import '/saudi/presentation/home/controller/states.dart';
import '/saudi/presentation/products/view/products_screen.dart';
import '/saudi/presentation/search/view/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/styles_manager.dart';
import '/app/resources/values_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..getProduct()
        ..getCategories(),
      child: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                HomeBloc.get(context).products.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (__) => SearchScreen(
                                products: HomeBloc.get(context).products,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / AppSize.s20,
                            vertical: MediaQuery.of(context).size.height /
                                AppSize.s50,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSize.s4,
                            ),
                            border: Border.all(
                              color: ColorManager.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: ColorManager.grey,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    AppSize.s20,
                              ),
                              Text(
                                AppStrings.searchHint.tr(),
                                style: getMediumStyle(
                                  fontSize: FontSizeManager.s16.sp,
                                  color: ColorManager.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                ),
                sliderBanner(banners: HomeBloc.get(context).banners),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s30,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.category_outlined,
                      size: AppSize.s30.w,
                      color: ColorManager.grey,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s40,
                    ),
                    Text(
                      AppStrings.brands.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s60,
                ),
                SizedBox(
                  height: AppSize.s150.h,
                  child: HomeBloc.get(context).categories.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => brandItem(
                            label: HomeBloc.get(context)
                                .sortedCategories()[index]
                                .name,
                            context: context,
                            id: HomeBloc.get(context)
                                .sortedCategories()[index]
                                .id,
                            branName: HomeBloc.get(context).categoriesLabel(
                              id: HomeBloc.get(context)
                                  .sortedCategories()[index]
                                  .id,
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width:
                                MediaQuery.of(context).size.width / AppSize.s40,
                          ),
                          itemCount: HomeBloc.get(context).categories.length,
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                              color: ColorManager.green),
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        AppStrings.newProduct.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s60,
                    ),
                    HomeBloc.get(context).products.isEmpty
                        ? SizedBox(
                            height: AppSize.s150.h,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.green,
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SharedWidget.productItem(
                                context: context,
                                model: HomeBloc.get(context).products[index],
                              );
                            },
                            semanticChildCount: 2,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSize.s10.w,
                              crossAxisSpacing: AppSize.s5.h,
                              childAspectRatio: 2.0 / 3.166,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget sliderBanner({required List<String> banners}) => CarouselSlider(
        carouselController: CarouselController(),
        items: banners
            .map(
              (e) => Container(
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  border: Border.all(
                    color: CacheHelper.getData(key: SharedKey.isDark) == true
                        ? ColorManager.white
                        : ColorManager.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppSize.s10,
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      e,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s200.h,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(
            seconds: AppIntDuration.duration3,
          ),
          autoPlayAnimationDuration: const Duration(
            milliseconds: AppIntDuration.duration500,
          ),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget brandItem({
    required BuildContext context,
    required String label,
    required int id,
    required String branName,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsScreen(id: id, branName: branName),
          ),
        );
      },
      child: HomeBloc.get(context).categoriesModel.data.isEmpty
          ? const SizedBox.shrink()
          : SizedBox(
              width: AppSize.s100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: AppSize.s100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.s10,
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          HomeBloc.get(context).categoriesImage(
                            id: id,
                          ),
                        ),
                      ),
                      color: CacheHelper.getData(key: SharedKey.isDark) == true
                          ? ColorManager.primaryColor
                          : ColorManager.white,
                      border: Border.all(
                        color:
                            CacheHelper.getData(key: SharedKey.isDark) == true
                                ? ColorManager.white
                                : ColorManager.primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    HomeBloc.get(context).categoriesLabel(
                      id: id,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
    );
  }
}
