import '/app/common/empty_widget.dart';

import '../../../../app/common/handle_error_from_api_widget.dart';
import '/egypt/data/products/repository/egypt_product_repository.dart';
import '/egypt/data/products/repository/egypt_product_repository_impl.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/app/common/widget.dart';
import '/app/resources/strings_manager.dart';
import '/app/resources/values_manager.dart';

class EgyptSearchScreen extends StatefulWidget {
  const EgyptSearchScreen({
    super.key,
  });

  @override
  State<EgyptSearchScreen> createState() => _EgyptSearchScreenState();
}

class _EgyptSearchScreenState extends State<EgyptSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final EgyptProductRepository _productRepository =
      EgyptProductRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
        ),
        child: Column(
          children: [
            SharedWidget.defaultTextFormField(
              controller: _searchController,
              textInputType: TextInputType.text,
              context: context,
              // onFieldSubmitted: (String? value) {
              //   EgyptHomeBloc.get(context).searchInProducts(
              //     productsList: widget.products,
              //     value: value!,
              //   );
              // },
              prefixIcon: const Icon(
                Icons.search,
              ),
              hint: AppStrings.searchHint.tr(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s40),
                child: FutureBuilder(
                  future: _productRepository.searchForEgyptProducts(
                    _searchController.text,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const HandleErrorFromApiWidget();
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.data.isNotEmpty) {
                        return GridView.builder(
                          itemCount: snapshot.data!.data.length,
                          physics: const BouncingScrollPhysics(),
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
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
