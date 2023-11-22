import '/saudi/presentation/cart/controller/states.dart';
import '/saudi/presentation/checkout/controller/bloc.dart';
import '/saudi/presentation/checkout/controller/states.dart';
import '/saudi/presentation/layout/controller/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/common/widget.dart';
import '/app/resources/assets_manager.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/routes_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/resources/values_manager.dart';
import '../../cart/controller/bloc.dart';
import '../../layout/controller/bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.fullName,
    required this.apartment,
    required this.area,
    required this.building,
    required this.city,
    required this.countryId,
    required this.email,
    required this.phone,
    required this.postalCode,
    required this.stateId,
  });
  final String fullName;
  final String email;
  final String phone;
  final int countryId;
  final String city;
  final int stateId;
  final String area;
  final String building;
  final String apartment;
  final String postalCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.confirmation.tr(),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) =>
                CheckoutBloc()..productsInCart(LayoutBloc.get(context).cart),
          ),
          BlocProvider(
            create: (context) => LayoutBloc()
              ..getDataFromDataBase(
                LayoutBloc.get(context).database,
              ),
          ),
        ],
        child: BlocConsumer<CheckoutBloc, CheckoutStates>(
          listener: (context, state) {
            if (state is CheckoutSuccessState) {
              SharedWidget.toast(
                message: AppStrings.success.tr(),
                backgroundColor: ColorManager.green,
              );
              Navigator.pushNamed(context, Routes.layoutRoute);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s20,
                vertical: MediaQuery.of(context).size.height / AppSize.s80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical:
                          MediaQuery.of(context).size.height / AppSize.s50,
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s60,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(
                        AppSize.s10.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.fullName.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                fullName,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.email.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                email,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.phoneNumber.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                phone,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.area.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              ":",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s30,
                            ),
                            Expanded(
                              child: Text(
                                area,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Text(
                    AppStrings.orderDetails.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Expanded(child: BlocBuilder<LayoutBloc, LayoutStates>(
                    builder: (context, state) {
                      return ListView.separated(
                        itemBuilder: (context, index) => cartItem(
                          context: context,
                          model: LayoutBloc.get(context).cart[index],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s60,
                        ),
                        itemCount: LayoutBloc.get(context).cart.length,
                      );
                    },
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  BlocBuilder<CartBloc, CartStates>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.totalPrice.tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "${CartBloc.get(context).totalPrice(cart: LayoutBloc.get(context).cart)}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.deliveryMethod.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        AppStrings.cashOnDelivery.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  state is CheckoutLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.green,
                          ),
                        )
                      : SharedWidget.defaultButton(
                          label: AppStrings.confirmation.tr(),
                          context: context,
                          width: double.infinity,
                          onPressed: () {
                            CheckoutBloc.get(context).checkout(
                                fullName: fullName,
                                email: email,
                                phone: phone,
                                countryId: countryId,
                                city: city,
                                stateId: stateId,
                                area: area,
                                building: building,
                                apartment: apartment,
                                postalCode: postalCode);
                            for (var element
                                in CheckoutBloc.get(context).products) {
                              LayoutBloc.get(context)
                                  .deleteFromDataBase(id: element["id"]);
                            }
                          },
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s60,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget cartItem({
    required Map model,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: AppSize.s120.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(
                  AppSize.s8.w,
                ),
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
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / AppSize.s50,
          ),
          Expanded(
            flex: 2,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s50),
                  child: Text(
                    "${model["quantity"]}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
