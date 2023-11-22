// ignore_for_file: must_be_immutable, dead_code

import '/app/common/empty_widget.dart';
import '/egypt/data/products/models/egypt_all_products_model.dart';
import '/egypt/data/products/models/egypt_product_model.dart';
import '/egypt/data/products/repository/egypt_product_repository.dart';

import '../../../../app/common/handle_error_from_api_widget.dart';
import '../../../data/products/repository/egypt_product_repository_impl.dart';
import '../../home/controller/bloc.dart';
import '../../layout/controller/bloc.dart';
import '../../layout/controller/states.dart';
import '../controller/bloc.dart';
import '/app/resources/assets_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/routes_manager.dart';
import '/app/resources/values_manager.dart';

class EgyptProductDetailsScreen extends StatelessWidget {
  late String name;
  late double price;
  late String image;
  late double quantity;
  late String categoryName;
  late int id;

  EgyptProductDetailsScreen({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.categoryName,
  });

  final EgyptProductRepository _productRepository =
      EgyptProductRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EgyptHomeBloc(),
        ),
        BlocProvider(
          create: (context) => EgyptProductDetailsBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.productDetails.tr(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.egyptCartRoute,
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
        body: FutureBuilder<EgyptProductModel>(
          future: _productRepository.getEgyptProduct(id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const HandleErrorFromApiWidget();
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s80,
                        ),
                        sliderBanner(
                          context: context,
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / AppSize.s30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              AppSize.s20,
                                    ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppStrings.price.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: ColorManager.green,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .width /
                                                AppSize.s22,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$price EGP",
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: ColorManager.blackGrey,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .width /
                                                AppSize.s22,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppStrings.priceWithTax.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: ColorManager.green,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .width /
                                                AppSize.s22,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${snapshot.data?.data.price} EGP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: ColorManager.blackGrey,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .width /
                                                AppSize.s22,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                categoryName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              AppSize.s20,
                                    ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.available.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  AppSize.s24,
                                        ),
                                  ),
                                  Text(
                                    "${quantity.toInt()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  AppSize.s24,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s40,
                              ),
                              Text(
                                snapshot.data?.data.description ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: ColorManager.mintGreen,
                                      fontSize:
                                          MediaQuery.sizeOf(context).width /
                                              AppSize.s22,
                                    ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              BlocBuilder<EgyptLayoutBloc, EgyptLayoutStates>(
                                  builder: (context, state) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: SharedWidget.defaultButton(
                                        label: AppStrings.addToCart.tr(),
                                        context: context,
                                        width: double.infinity,
                                        onPressed: () {
                                          EgyptLayoutBloc.get(context)
                                              .insertDataBase(
                                            id: id,
                                            title: name,
                                            image: image,
                                            price: snapshot.data!.data.price
                                                .toDouble(),
                                            quantity:
                                                EgyptProductDetailsBloc.get(
                                                        context)
                                                    .counter,
                                            categoryName: categoryName,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          AppSize.s30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        EgyptLayoutBloc.get(context)
                                            .upDateDataBase(
                                                id: id,
                                                quantity: EgyptProductDetailsBloc
                                                        .get(context)
                                                    .incrementProductCounter());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AppSize.s8,
                                          ),
                                          color: ColorManager.mintGreen,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s40,
                                        ),
                                        child: Text(
                                          "+",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize:
                                                    FontSizeManager.s16.sp,
                                                color: ColorManager.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s50),
                                      child: Text(
                                        "${EgyptProductDetailsBloc.get(context).counter}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        EgyptLayoutBloc.get(context)
                                            .upDateDataBase(
                                                id: id,
                                                quantity: EgyptProductDetailsBloc
                                                        .get(context)
                                                    .decrementProductCounter());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            AppSize.s8,
                                          ),
                                          color: ColorManager.mintGreen,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s40,
                                        ),
                                        child: Text(
                                          "-",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize:
                                                    FontSizeManager.s16.sp,
                                                color: ColorManager.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.otherProducts.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s60,
                          ),
                          FutureBuilder<EgyptAllProductsModel>(
                            future: _productRepository.getAllEgyptProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const HandleErrorFromApiWidget();
                              } else if (snapshot.hasData) {
                                snapshot.data!.data
                                    .removeWhere((element) => element.id == id);
                                if (snapshot.data!.data.isNotEmpty) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.data.length < 12
                                        ? snapshot.data!.data.length
                                        : 12,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                      mainAxisSpacing: AppSize.s6.w,
                                      crossAxisSpacing: AppSize.s6.h,
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
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s50,
                    ),
                  ],
                ),
              );
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
    );

    /*MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EgyptHomeBloc()..getProduct(),
        ),
        BlocProvider(
            create: (context) =>
                EgyptProductDetailsBloc()..getProductDetials(id: id))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.productDetails.tr(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.egyptCartRoute,
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              BlocBuilder<EgyptProductDetailsBloc, EgyptProductDetailsStates>(
                builder: (context, state) {
                  debugPrint(image);
                  return Column(
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      sliderBanner(
                        context: context,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: MediaQuery.sizeOf(context).width /
                                        AppSize.s20,
                                  ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.price.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: ColorManager.green,
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  AppSize.s22,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "$price SR",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: ColorManager.blackGrey,
                                          fontSize:
                                              MediaQuery.sizeOf(context).width /
                                                  AppSize.s22,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            EgyptProductDetailsBloc.get(context)
                                        .productDetailsModel
                                        .data
                                        .priceWithTax !=
                                    null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          AppStrings.priceWithTax.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: ColorManager.green,
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        AppSize.s22,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${EgyptProductDetailsBloc.get(context).productDetailsModel.data.priceWithTax} SR",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: ColorManager.blackGrey,
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        AppSize.s22,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Text(
                              categoryName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: MediaQuery.sizeOf(context).width /
                                        AppSize.s20,
                                  ),
                            ),
                            Row(
                              children: [
                                Text(
                                  AppStrings.available.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width /
                                                AppSize.s24,
                                      ),
                                ),
                                Text(
                                  "${quantity.toInt()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width /
                                                AppSize.s24,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s40,
                            ),
                            Text(
                              EgyptProductDetailsBloc.get(context)
                                          .productDetailsModel
                                          .data
                                          .description ==
                                      false
                                  ? ""
                                  : EgyptProductDetailsBloc.get(context)
                                              .productDetailsModel
                                              .data
                                              .description !=
                                          null
                                      ? EgyptProductDetailsBloc.get(context)
                                          .productDetailsModel
                                          .data
                                          .description
                                          .toString()
                                      : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: ColorManager.mintGreen,
                                    fontSize: MediaQuery.sizeOf(context).width /
                                        AppSize.s22,
                                  ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s50,
                            ),
                            EgyptProductDetailsBloc.get(context)
                                        .productDetailsModel
                                        .data
                                        .priceWithTax !=
                                    null
                                ? BlocBuilder<EgyptLayoutBloc,
                                        EgyptLayoutStates>(
                                    builder: (context, state) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: SharedWidget.defaultButton(
                                            label: AppStrings.addToCart.tr(),
                                            context: context,
                                            width: double.infinity,
                                            onPressed: () {
                                              EgyptLayoutBloc.get(context)
                                                  .insertDataBase(
                                                id: id,
                                                title: name,
                                                image: image,
                                                price:
                                                    EgyptProductDetailsBloc.get(
                                                            context)
                                                        .productDetailsModel
                                                        .data
                                                        .priceWithTax!,
                                                quantity:
                                                    EgyptProductDetailsBloc.get(
                                                            context)
                                                        .counter,
                                                categoryName: categoryName,
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              AppSize.s30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            EgyptLayoutBloc.get(context)
                                                .upDateDataBase(
                                                    id: id,
                                                    quantity:
                                                        EgyptProductDetailsBloc
                                                                .get(context)
                                                            .incrementProductCounter());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                AppSize.s8,
                                              ),
                                              color: ColorManager.mintGreen,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  AppSize.s40,
                                            ),
                                            child: Text(
                                              "+",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize:
                                                        FontSizeManager.s16.sp,
                                                    color: ColorManager.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  AppSize.s50),
                                          child: Text(
                                            "${EgyptProductDetailsBloc.get(context).counter}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            EgyptLayoutBloc.get(context)
                                                .upDateDataBase(
                                                    id: id,
                                                    quantity:
                                                        EgyptProductDetailsBloc
                                                                .get(context)
                                                            .decrementProductCounter());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                AppSize.s8,
                                              ),
                                              color: ColorManager.mintGreen,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  AppSize.s40,
                                            ),
                                            child: Text(
                                              "-",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize:
                                                        FontSizeManager.s16.sp,
                                                    color: ColorManager.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                : const SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<EgyptHomeBloc, EgyptHomeStates>(
                builder: (context, state) {
                  return EgyptHomeBloc.get(context).products.isEmpty
                      ? SizedBox(
                          height: AppSize.s150.h,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.green,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width /
                                  AppSize.s30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.otherProducts.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s60,
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                itemCount: 12,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SharedWidget.egyptProductItem(
                                    context: context,
                                    model: EgyptHomeBloc.get(context)
                                        .products[index],
                                  );
                                },
                                semanticChildCount: 2,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: AppSize.s6.w,
                                  crossAxisSpacing: AppSize.s6.h,
                                  childAspectRatio: 2.0 / 3.166,
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s50,
              ),
            ],
          ),
        ),
      ),
    );*/
  }

  Widget sliderBanner({
    required BuildContext context,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
        ),
        child: Container(
          height: AppSize.s200.h,
          decoration: BoxDecoration(
            color: ColorManager.white,
            image: image.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                    fit: BoxFit.contain,
                  )
                : const DecorationImage(
                    image: AssetImage(
                      AssetsManager.noImage,
                    ),
                    fit: BoxFit.contain,
                  ),
            borderRadius: BorderRadius.circular(
              AppSize.s10,
            ),
            border: Border.all(
              color: CacheHelper.getData(key: SharedKey.isDark) == true
                  ? ColorManager.white
                  : ColorManager.primaryColor,
            ),
          ),
        ),
      );
}
