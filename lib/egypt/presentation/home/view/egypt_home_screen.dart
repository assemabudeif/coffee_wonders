// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import '/egypt/data/brand/repository/egypt_brand_repository.dart';
import '/egypt/data/products/repository/egypt_product_repository.dart';
import '/egypt/data/products/repository/egypt_product_repository_impl.dart';
import '../../../../app/common/empty_widget.dart';
import '../../../../app/common/handle_error_from_api_widget.dart';
import '../../../data/brand/repository/egypt_brand_repository_impl.dart';
import '../../brand_products/view/egypt_products_screen.dart';
import '../../search/view/egypt_search_screen.dart';
import '../controller/bloc.dart';
import '../controller/states.dart';
import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/styles_manager.dart';
import '/app/resources/values_manager.dart';

class EgyptHomeScreen extends StatelessWidget {
  EgyptHomeScreen({super.key});
  final EgyptProductRepository productRepository = EgyptProductRepositoryImpl();
  final EgyptBrandRepository brandRepository = EgyptBrandRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EgyptHomeBloc()
        // ..getProduct()
        ..getCategories(),
      child: BlocBuilder<EgyptHomeBloc, EgyptHomeStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (__) => const EgyptSearchScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s20,
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s50,
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
                          width:
                              MediaQuery.of(context).size.width / AppSize.s20,
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / AppSize.s50,
                ),
                sliderBanner(banners: EgyptHomeBloc.get(context).banners),
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
                  child: FutureBuilder(
                    future: brandRepository.getAllBrands(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const HandleErrorFromApiWidget();
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.data.isNotEmpty) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => brandItem(
                              image: snapshot.data!.data[index].photo,
                              label: snapshot.data!.data[index].name,
                              context: context,
                              id: snapshot.data!.data[index].id,
                              branName: snapshot.data!.data[index].name,
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s40,
                            ),
                            itemCount: snapshot.data!.data.length,
                          );
                        } else {
                          return const EmptyWidget();
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.green,
                          ),
                        );
                      }
                    },
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
                    FutureBuilder(
                      future: productRepository.getAllEgyptProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const HandleErrorFromApiWidget();
                        } else if (snapshot.hasData) {
                          if (snapshot.data!.data.isNotEmpty) {
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SharedWidget.egyptProductItem(
                                  context: context,
                                  model: snapshot.data!.data[index],
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
                            );
                          } else {
                            return const EmptyWidget();
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.green,
                            ),
                          );
                        }
                      },
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
    required String image,
    required int id,
    required String branName,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EgyptProductsScreen(id: id, branName: branName),
          ),
        );
      },
      child: SizedBox(
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
                  image: NetworkImage(
                    image,
                  ),
                ),
                color: CacheHelper.getData(key: SharedKey.isDark) == true
                    ? ColorManager.primaryColor
                    : ColorManager.white,
                border: Border.all(
                  color: CacheHelper.getData(key: SharedKey.isDark) == true
                      ? ColorManager.white
                      : ColorManager.primaryColor,
                ),
              ),
            ),
            Text(
              label,
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
