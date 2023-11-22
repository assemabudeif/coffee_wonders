// ignore_for_file: library_prefixes

import '/saudi/presentation/home/controller/bloc.dart';
import '/saudi/presentation/home/controller/states.dart';
import '/saudi/presentation/layout/controller/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/app/common/function.dart';
import '/app/resources/color_manager.dart';
import '/app/resources/font_manager.dart';
import '/app/resources/routes_manager.dart';
import '/app/resources/strings_manager.dart';
import '/app/resources/values_manager.dart';

import '/app/services/shared_prefrences/cache_helper.dart';
import '../controller/bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..getCategories(),
        child: BlocBuilder<LayoutBloc, LayoutStates>(
          builder: (context, state) {
            return BlocBuilder<HomeBloc, HomeStates>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(LayoutBloc.get(context)
                        .appBarTitle[LayoutBloc.get(context).index]),
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
                  drawer: drawerItem(
                    context: context,
                  ),
                  body: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s30,
                      ),
                      child: LayoutBloc.get(context)
                          .screens[LayoutBloc.get(context).index]),
                  bottomNavigationBar: BottomNavigationBar(
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.category_outlined,
                        ),
                        label: "Category",
                      ),
                    ],
                    currentIndex: LayoutBloc.get(context).index,
                    onTap: (index) {
                      LayoutBloc.get(context).changeBottomNavBar(index);
                    },
                  ),
                );
              },
            );
          },
        ));
  }

  Widget drawerItem({
    required BuildContext context,
  }) {
    return Drawer(
      backgroundColor: CacheHelper.getData(key: SharedKey.isDark) == true
          ? ColorManager.black
          : ColorManager.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s30,
            vertical: MediaQuery.of(context).size.height / AppSize.s10,
          ),
          child: Column(
            children: [
              drawerListItem(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                  LayoutBloc.get(context).changeBottomNavBar(0);
                },
                icon: Icons.home_outlined,
                text: AppStrings.home.tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              drawerListItem(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    Routes.aboutUsRoute,
                  );
                },
                icon: Icons.info_outline,
                text: AppStrings.aboutUs.tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              drawerListItem(
                context: context,
                onTap: () {
                  SharedFunction.changeLanguage(context);
                },
                icon: Icons.language_outlined,
                text: AppStrings.languages.tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / AppSize.s40,
              ),
              drawerListItem(
                context: context,
                onTap: () {
                  SharedFunction.changeAppMode(
                    context,
                  );
                },
                icon: Icons.dark_mode_outlined,
                text: CacheHelper.getData(key: SharedKey.isDark) == true
                    ? AppStrings.lightMode.tr()
                    : AppStrings.darkMode.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerListItem({
    required BuildContext context,
    required Function() onTap,
    required IconData icon,
    required String text,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorManager.grey,
            size: AppSize.s26.w,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / AppSize.s16,
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: FontSizeManager.s18.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
