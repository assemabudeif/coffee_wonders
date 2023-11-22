// ignore_for_file: must_be_immutable

import '/app/resources/color_manager.dart';
import '/app/resources/values_manager.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import '/saudi/presentation/home/controller/bloc.dart';
import '/saudi/presentation/home/controller/states.dart';
import '/saudi/presentation/products/view/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..getCategories(),
        child: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            return HomeBloc.get(context).categories.isNotEmpty
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => brandItem(
                      context: context,
                      label:
                          HomeBloc.get(context).sortedCategories()[index].name,
                      id: HomeBloc.get(context).sortedCategories()[index].id,
                      brandName: HomeBloc.get(context).categoriesLabel(
                        id: HomeBloc.get(context).sortedCategories()[index].id,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s40,
                    ),
                    itemCount: HomeBloc.get(context).categories.length,
                  )
                : const Center(
                    child: CircularProgressIndicator(color: ColorManager.green),
                  );
          },
        ));
  }
}

Widget brandItem({
  required BuildContext context,
  required String label,
  required int id,
  required String brandName,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductsScreen(
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
            image: DecorationImage(
              image: AssetImage(
                HomeBloc.get(context).categoriesImage(
                  id: id,
                ),
              ),
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
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / AppSize.s40,
        ),
        Expanded(
          child: Text(
            HomeBloc.get(context).categoriesLabel(
              id: id,
            ),
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
  );
}
