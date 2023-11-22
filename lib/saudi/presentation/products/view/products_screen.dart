// ignore_for_file: must_be_immutable

import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import '/saudi/presentation/products/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/resources/routes_manager.dart';
import '/app/resources/values_manager.dart';
import '../controller/bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.id,
    required this.branName,
  });
  final String branName;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(branName),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.cartRoute,
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ProductsBloc()..getProductsByCategoryId(id: id),
        child: BlocBuilder<ProductsBloc, ProductsStates>(
            builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / AppSize.s60,
              horizontal: MediaQuery.of(context).size.width / AppSize.s40,
            ),
            child: ProductsBloc.get(context).productModel.data.isNotEmpty
                ? GridView.builder(
                    itemCount:
                        ProductsBloc.get(context).productModel.data.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SharedWidget.productItem(
                        context: context,
                        model:
                            ProductsBloc.get(context).productModel.data[index],
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
      ),
    );
  }
}
