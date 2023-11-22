import 'dart:developer';

import '/app/common/empty_widget.dart';
import '/egypt/data/products/models/egypt_product_model.dart';

import '../../../../app/common/handle_error_from_api_widget.dart';
import '../../../data/brand/models/egypt_brand_products_model.dart';
import '../../../data/brand/repository/egypt_brand_repository.dart';
import '../../../data/brand/repository/egypt_brand_repository_impl.dart';
import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/resources/routes_manager.dart';
import '/app/resources/values_manager.dart';

class EgyptProductsScreen extends StatefulWidget {
  const EgyptProductsScreen({
    super.key,
    required this.id,
    required this.branName,
  });
  final String branName;
  final int id;

  @override
  State<EgyptProductsScreen> createState() => _EgyptProductsScreenState();
}

class _EgyptProductsScreenState extends State<EgyptProductsScreen> {
  final EgyptBrandRepository repository = EgyptBrandRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branName),
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
      body: FutureBuilder<EgyptBrandProductsModel>(
        future: repository.getBrandProducts(widget.id.toString()),
        builder: (context, snapshot) {
          log('Data: ${snapshot.data?.data.toString()}');
          if (snapshot.hasError) {
            return const HandleErrorFromApiWidget();
          } else if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / AppSize.s60,
                horizontal: MediaQuery.of(context).size.width / AppSize.s40,
              ),
              child: snapshot.data!.data.products.isNotEmpty
                  ? GridView.builder(
                      itemCount: snapshot.data!.data.products.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SharedWidget.egyptProductItem(
                          context: context,
                          model: EgyptProductDataModel.fromJson(
                            snapshot.data!.data.products[index].toJson(),
                          ),
                        );
                      },
                      semanticChildCount: 2,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSize.s10.w,
                        crossAxisSpacing: AppSize.s5.h,
                        childAspectRatio: 2.0 / 3.166,
                      ),
                    )
                  : const EmptyWidget(),
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

      /*BlocProvider(
        create: (context) =>
            EgyptProductsBloc()..getProductsByCategoryId(id: widget.id),
        child: BlocBuilder<EgyptProductsBloc, EgyptProductsStates>(
            builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / AppSize.s60,
              horizontal: MediaQuery.of(context).size.width / AppSize.s40,
            ),
            child: EgyptProductsBloc.get(context).productModel.data.isNotEmpty
                ? GridView.builder(
                    itemCount:
                        EgyptProductsBloc.get(context).productModel.data.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SharedWidget.egyptProductItem(
                        context: context,
                        model: EgyptProductsBloc.get(context)
                            .productModel
                            .data[index],
                      );
                    },
                    semanticChildCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSize.s10.w,
                      crossAxisSpacing: AppSize.s5.h,
                      childAspectRatio: 2.0 / 3.166,
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.green,
                    ),
                  ),
          );
        }),
      ),*/
    );
  }
}
