import '/app/resources/assets_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import '/saudi/presentation/cart/controller/states.dart';
import '/saudi/presentation/confirmation/view/confirmation_screen.dart';
import '/saudi/presentation/layout/controller/bloc.dart';
import '/saudi/presentation/layout/controller/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/resources/values_manager.dart';
import '../controller/bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutBloc.get(context)
        .getDataFromDataBase(LayoutBloc.get(context).database);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.myCart.tr(),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartBloc(),
          ),
        ],
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s50,
              vertical: MediaQuery.of(context).size.height / AppSize.s60,
            ),
            child: BlocBuilder<CartBloc, CartStates>(
              builder: (context, state) {
                return BlocBuilder<LayoutBloc, LayoutStates>(
                    builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: LayoutBloc.get(context).cart.isNotEmpty
                            ? ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => cartItem(
                                  model: LayoutBloc.get(context).cart[index],
                                  context: context,
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s60,
                                ),
                                itemCount: LayoutBloc.get(context).cart.length,
                              )
                            : Center(
                                child: Text(
                                  AppStrings.notFoundProducts.tr(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s60,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s50,
                        ),
                        child: Row(
                          children: [
                            Text(
                              style: Theme.of(context).textTheme.bodyMedium,
                              AppStrings.totalPrice.tr(),
                            ),
                            const Spacer(),
                            Text(
                              "${CartBloc.get(context).totalPrice(cart: LayoutBloc.get(context).cart)}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s60,
                      ),
                      SharedWidget.defaultButton(
                        label: AppStrings.goToCheckout.tr(),
                        context: context,
                        width: double.infinity,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConfirmationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                });
              },
            )),
      ),
    );
  }

  Widget cartItem({
    required BuildContext context,
    required Map model,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: AppSize.s130.h,
            decoration: BoxDecoration(
              image: model["image"].toString().isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                        model["image"],
                      ),
                      fit: BoxFit.fill,
                    )
                  : const DecorationImage(
                      image: AssetImage(
                        AssetsManager.noImage,
                      ),
                      fit: BoxFit.fill,
                    ),
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(
                AppSize.s8.w,
              ),
              border: Border.all(
                color: CacheHelper.getData(key: SharedKey.isDark) == true
                    ? ColorManager.white
                    : ColorManager.primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / AppSize.s50,
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model["title"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s60,
              ),
              Text(
                "${model["price"]}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      LayoutBloc.get(context).upDateDataBase(
                          id: model["id"],
                          quantity: CartBloc.get(context)
                              .incrementProductCounter(
                                  quantity: model["quantity"]));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                        color: ColorManager.mintGreen,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s40,
                      ),
                      child: Text(
                        "+",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSizeManager.s16.sp,
                              color: ColorManager.white,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50),
                    child: Text(
                      "${model["quantity"]}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      LayoutBloc.get(context).upDateDataBase(
                          id: model["id"],
                          quantity: CartBloc.get(context)
                              .decrementProductCounter(
                                  quantity: model["quantity"]));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                        color: ColorManager.mintGreen,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s40,
                      ),
                      child: Text(
                        "-",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: FontSizeManager.s16.sp,
                              color: ColorManager.white,
                            ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topStart,
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: CacheHelper.getData(key: SharedKey.isDark) == true
                  ? ColorManager.white
                  : ColorManager.black,
            ),
            onPressed: () {
              LayoutBloc.get(context).deleteFromDataBase(id: model["id"]);
            },
          ),
        )
      ],
    );
  }
}
