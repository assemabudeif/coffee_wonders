import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/common/empty_widget.dart';
import '../../../app/common/handle_error_from_api_widget.dart';
import '../../data/categories/models/egypt_category_brands_model.dart';
import '../../data/categories/repository/categories_repository_impl.dart';
import '../brands/view/egypt_brands_screen.dart';
import '../widgets/widgets.dart';

class EgyptCategoryBrandsScreen extends StatelessWidget {
  const EgyptCategoryBrandsScreen(
      {Key? key, required this.categoryId, required this.title})
      : super(key: key);
  final String categoryId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: FutureBuilder<EgyptCategoryBrandsModel>(
          future: CategoriesRepositoryImpl().getCategoryBrands(
            categoryId,
          ),
          builder: (context, snapshot) {
            log(snapshot.error.toString());
            if (snapshot.hasError) {
              return const HandleErrorFromApiWidget();
            } else if (snapshot.hasData) {
              if (snapshot.data?.data.isNotEmpty ?? false) {
                return ListView.separated(
                  itemBuilder: (context, index) => brandItem(
                    context: context,
                    label: snapshot.data!.data[index].name,
                    image: snapshot.data!.data[index].photo,
                    id: snapshot.data!.data[index].id,
                    brandName: snapshot.data!.data[index].name,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.data.length,
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
    );
  }
}
