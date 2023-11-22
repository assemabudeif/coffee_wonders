import '/saudi/presentation/checkout/view/checkout_screen.dart';
import '/saudi/presentation/confirmation/controller/bloc.dart';
import '/saudi/presentation/confirmation/controller/states.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/common/widget.dart';
import '/app/resources/assets_manager.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/language_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/resources/styles_manager.dart';
import '/app/resources/values_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  var formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final buildingController = TextEditingController();
  final apartmentController = TextEditingController();
  final postalCodeController = TextEditingController();
  List areaList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmationBloc()..getCountries(),
      child: BlocBuilder<ConfirmationBloc, ConfirmationStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.confirmation.tr(),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / AppSize.s60,
                horizontal: MediaQuery.of(context).size.width / AppSize.s40,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConfirmationBloc.get(context).countryName.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SharedWidget.defaultTextFormField(
                              controller: fullNameController,
                              textInputType: TextInputType.name,
                              hint: AppStrings.fullName.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            SharedWidget.defaultTextFormField(
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                              hint: AppStrings.email.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            SharedWidget.defaultTextFormField(
                              controller: phoneNumberController,
                              textInputType: TextInputType.phone,
                              hint: AppStrings.phoneNumber.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            countryDropDownItem(
                              context: context,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            ConfirmationBloc.get(context).stateName.isNotEmpty
                                ? stateDropDownItem(
                                    context: context,
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            SharedWidget.defaultTextFormField(
                              controller: areaController,
                              textInputType: TextInputType.text,
                              hint: AppStrings.area.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            SharedWidget.defaultTextFormField(
                              controller: buildingController,
                              textInputType: TextInputType.number,
                              hint: AppStrings.building.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            SharedWidget.defaultTextFormField(
                              controller: apartmentController,
                              textInputType: TextInputType.number,
                              hint: AppStrings.apartment.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s60,
                            ),
                            SharedWidget.defaultTextFormField(
                              controller: postalCodeController,
                              textInputType: TextInputType.number,
                              hint: AppStrings.postalCode.tr(),
                              context: context,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return AppStrings.thisIsRequired.tr();
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s20,
                            ),
                            SharedWidget.defaultButton(
                              label: AppStrings.confirmation.tr(),
                              context: context,
                              width: double.infinity,
                              onPressed: () {
                                int? countryId =
                                    ConfirmationBloc.get(context).countryId;
                                int? stateId =
                                    ConfirmationBloc.get(context).stateId;
                                if (formKey.currentState!.validate() &&
                                    ConfirmationBloc.get(context).countryId !=
                                        null &&
                                    ConfirmationBloc.get(context).stateId !=
                                        null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        apartment: apartmentController.text,
                                        area: areaController.text,
                                        building: buildingController.text,
                                        city: cityController.text,
                                        countryId: countryId!,
                                        email: emailController.text,
                                        fullName: fullNameController.text,
                                        phone: phoneNumberController.text,
                                        postalCode: postalCodeController.text,
                                        stateId: stateId!,
                                      ),
                                    ),
                                  );
                                } else {
                                  SharedWidget.toast(
                                    message:
                                        AppStrings.countryAndStateValidate.tr(),
                                    backgroundColor: ColorManager.error,
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  AppSize.s20,
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.green,
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget countryDropDownItem({
    required BuildContext context,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        iconOnClick: Image(
          image: const AssetImage(
            AssetsManager.arrowUp,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.country.tr(),
                style: getMediumStyle(
                  fontSize: FontSizeManager.s16.sp,
                  color: ColorManager.primaryColor,
                ),
              ),
            ),
          ],
        ),
        items: ConfirmationBloc.get(context)
            .countryName
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: ConfirmationBloc.get(context).countryValue,
        onChanged: (String? value) {
          ConfirmationBloc.get(context)
              .changeCountryDropDownItem(value: value!);
        },
        icon: Image(
          image: const AssetImage(
            AssetsManager.arrowDown,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        buttonHeight: AppSize.s50.h,
        buttonWidth: double.infinity,
        buttonDecoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(
            AppSize.s4.w,
          ),
          color: ColorManager.white,
        ),
        buttonPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s16,
        ),
        itemHeight: AppSize.s42.h,
        dropdownMaxHeight: AppSize.s150.h,
        dropdownWidth: MediaQuery.of(context).size.width / AppSize.s1_2,
        scrollbarRadius: Radius.circular(
          AppSize.s4.w,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              AppSize.s4.w,
            ),
            bottomRight: Radius.circular(
              AppSize.s4.w,
            ),
          ),
          color: ColorManager.white,
        ),
        scrollbarThickness: AppSize.s8.w,
        offset: CacheHelper.getData(key: SharedKey.Language) ==
                    LanguageType.ENGLISH.getValue() ||
                CacheHelper.getData(key: SharedKey.Language) == null
            ? Offset(AppSize.s20.w, 0)
            : Offset(-AppSize.s20.w, 0),
      ),
    );
  }

  Widget stateDropDownItem({
    required BuildContext context,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        iconOnClick: Image(
          image: const AssetImage(
            AssetsManager.arrowUp,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.state.tr(),
                style: getMediumStyle(
                  fontSize: FontSizeManager.s16.sp,
                  color: ColorManager.primaryColor,
                ),
              ),
            ),
          ],
        ),
        items: ConfirmationBloc.get(context)
            .stateName
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: ConfirmationBloc.get(context).stateValue,
        onChanged: (String? value) {
          ConfirmationBloc.get(context).changeStateDropDownItem(value: value!);
        },
        icon: Image(
          image: const AssetImage(
            AssetsManager.arrowDown,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        buttonHeight: AppSize.s50.h,
        buttonWidth: double.infinity,
        buttonDecoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(
            AppSize.s4.w,
          ),
          color: ColorManager.white,
        ),
        buttonPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s16,
        ),
        itemHeight: AppSize.s42.h,
        dropdownMaxHeight: AppSize.s150.h,
        dropdownWidth: MediaQuery.of(context).size.width / AppSize.s1_2,
        scrollbarRadius: Radius.circular(
          AppSize.s4.w,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              AppSize.s4.w,
            ),
            bottomRight: Radius.circular(
              AppSize.s4.w,
            ),
          ),
          color: ColorManager.white,
        ),
        scrollbarThickness: AppSize.s8.w,
        offset: CacheHelper.getData(key: SharedKey.Language) ==
                    LanguageType.ENGLISH.getValue() ||
                CacheHelper.getData(key: SharedKey.Language) == null
            ? Offset(AppSize.s20.w, 0)
            : Offset(-AppSize.s20.w, 0),
      ),
    );
  }
}
