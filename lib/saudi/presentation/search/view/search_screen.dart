// ignore_for_file: must_be_immutable

import '/saudi/presentation/home/controller/bloc.dart';
import '/saudi/presentation/home/controller/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/resources/values_manager.dart';
import '../../../model/product_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    super.key,
    required this.products,
  });
  List<ProductDataModel> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / AppSize.s30,
              ),
              child: Column(
                children: [
                  SharedWidget.defaultTextFormField(
                    controller: HomeBloc.get(context).searchController,
                    textInputType: TextInputType.text,
                    context: context,
                    onFieldSubmitted: (String? value) {
                      HomeBloc.get(context).searchInProducts(
                        productsList: products,
                        value: value!,
                      );
                    },
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    hint: AppStrings.searchHint.tr(),
                  ),
                  HomeBloc.get(context).productSearch.isEmpty
                      ? Expanded(
                          child: Column(
                            children: [
                              const Spacer(),
                              Icon(
                                Icons.search_off_outlined,
                                size: AppSize.s100.w,
                                color: ColorManager.primaryColor,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s80,
                              ),
                              Text(
                                AppStrings.notFoundProducts.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height /
                                    AppSize.s40),
                            child: GridView.builder(
                              itemCount:
                                  HomeBloc.get(context).productSearch.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SharedWidget.productItem(
                                  context: context,
                                  model: HomeBloc.get(context)
                                      .productSearch[index],
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
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
