import 'dart:developer';

import '../../../../app/common/handle_error_from_api_widget.dart';
import '../../../data/brand/models/egypt_brand_model.dart';
import '../../../data/brand/repository/egypt_brand_repository.dart';
import '../../../data/brand/repository/egypt_brand_repository_impl.dart';
import '../../brand_products/view/egypt_products_screen.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/values_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EgyptBrandsScreen extends StatefulWidget {
  const EgyptBrandsScreen({super.key});

  @override
  State<EgyptBrandsScreen> createState() => _EgyptBrandsScreenState();
}

class _EgyptBrandsScreenState extends State<EgyptBrandsScreen> {
  EgyptBrandRepository repository = EgyptBrandRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EgyptBrandModel>(
      future: repository.getAllBrands(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // EgyptHomeBloc.get(context).categories.isNotEmpty
          log('Status ${snapshot.data!.status}');
          log('Data:  ${snapshot.data?.data.toString()}');
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s30,
              vertical: MediaQuery.of(context).size.height / AppSize.s40,
            ),
            itemBuilder: (context, index) => brandItem(
              image: snapshot.data!.data[index].photo,
              context: context,
              label: snapshot.data!.data[index].name,
              // EgyptHomeBloc.get(context).sortedCategories()[index].name,
              id: snapshot.data!.data[index].id,
              // EgyptHomeBloc.get(context).sortedCategories()[index].id,
              brandName: snapshot.data!.data[index].name,
              // EgyptHomeBloc.get(context).categoriesLabel(
              //   id: EgyptHomeBloc.get(context).sortedCategories()[index].id,
              // ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s40,
            ),
            itemCount: snapshot.data!.data.length,
            // EgyptHomeBloc.get(context).categories.length,
          );
        } else if (snapshot.hasError) {
          return const HandleErrorFromApiWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator(color: ColorManager.green),
          );
        }
      },
    );

    /*BlocProvider(
      create: (context) => EgyptHomeBloc()..getCategories(),
      child: BlocBuilder<EgyptHomeBloc, EgyptHomeStates>(
        builder: (context, state) {
          return EgyptHomeBloc.get(context).categories.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / AppSize.s30,
                    vertical: MediaQuery.of(context).size.height / AppSize.s40,
                  ),
                  itemBuilder: (context, index) => brandItem(
                    context: context,
                    label: EgyptHomeBloc.get(context)
                        .sortedCategories()[index]
                        .name,
                    id: EgyptHomeBloc.get(context).sortedCategories()[index].id,
                    brandName: EgyptHomeBloc.get(context).categoriesLabel(
                      id: EgyptHomeBloc.get(context)
                          .sortedCategories()[index]
                          .id,
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s40,
                  ),
                  itemCount: EgyptHomeBloc.get(context).categories.length,
                )
              : const Center(
                  child: CircularProgressIndicator(color: ColorManager.green),
                );
        },
      ),
    );*/
  }
}

Widget brandItem({
  required BuildContext context,
  required String label,
  required String image,
  required int id,
  required String brandName,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EgyptProductsScreen(
            id: id,
            branName: brandName,
          ),
        ),
      );
    },
    child: Row(
      children: [
        Container(
          height: AppSize.s100.h,
          width: AppSize.s100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppSize.s6,
            ),
            border: Border.all(
              color: CacheHelper.getData(key: SharedKey.isDark) == true
                  ? ColorManager.white
                  : ColorManager.primaryColor,
            ),
            color: CacheHelper.getData(key: SharedKey.isDark) == true
                ? ColorManager.primaryColor
                : ColorManager.white,
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error,
              color: ColorManager.error,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / AppSize.s40,
        ),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
  );
}
