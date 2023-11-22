import '/app/constant/saudi_api_constant.dart';
import '/app/services/dio_helper/saudi_dio_helper.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import '/saudi/model/product_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/resources/assets_manager.dart';
import '../../../model/category_model.dart';
import 'states.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitState());
  static HomeBloc get(context) => BlocProvider.of(context);
  List<String> banners = [
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner3,
  ];

  List<DataCategoriesModel> categories = [];

  List<DataCategoriesModel> sortedCategories() {
    List<DataCategoriesModel> sortedCategories = [];
    sortedCategories
        .add(categories.where((element) => element.id == 7544).first);
    sortedCategories
        .add(categories.where((element) => element.id == 7568).first);
    sortedCategories
        .add(categories.where((element) => element.id == 7537).first);
    sortedCategories
        .add(categories.where((element) => element.id == 7562).first);
    sortedCategories
        .add(categories.where((element) => element.id == 7536).first);

    for (DataCategoriesModel element in categories) {
      if (element.id == 7544 ||
          element.id == 7568 ||
          element.id == 7537 ||
          element.id == 7562 ||
          element.id == 7536) {
        continue;
      } else {
        sortedCategories.add(element);
      }
    }
    return sortedCategories;
  }

  CategoriesModel categoriesModel = CategoriesModel();
  void getCategories() {
    emit(CategoriesLoadingState());

    SaudiDioHelper.getData(
      path: SaudiApiConstant.categoriesPath,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      categories = [];
      categoriesModel = CategoriesModel.fromJson(value.data);
      for (var item in categoriesModel.data) {
        if (item.id == 7568 ||
            item.id == 7544 ||
            item.id == 7537 ||
            item.id == 7536 ||
            item.id == 7552 ||
            item.id == 7586 ||
            item.id == 7583 ||
            item.id == 7562 ||
            item.id == 7570 ||
            item.id == 7564 ||
            item.id == 7531 ||
            item.id == 7569 ||
            item.id == 7577 ||
            item.id == 7596 ||
            item.id == 7560 ||
            item.id == 7590) {
          categories.add(item);
        }
      }
      emit(CategoriesSuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState());
    });
  }

  String categoriesLabel({required int id}) {
    switch (id) {
      case 7568:
        return "Lacimbali";
      case 7544:
        return "Franke";
      case 7537:
        return "La marzocco";
      case 7536:
        return "Johny";
      case 7552:
        return "Migel";
      case 7586:
        return "Kalerm";
      case 7583:
        return "Frucosol";
      case 7562:
        return "Mahlkonig";

      case 7570:
        return "Anfim";
      case 7564:
        return "Animo";

      case 7569:
        return "Bonomi";
      case 7577:
        return "Chino";
      case 7560:
        return "Coffee Planet";
      case 7531:
        return "Eureka";

      case 7590:
        return "Lelit";
      case 7596:
        return "Vitamin Bar";
      default:
        return "";
    }
  }

  String categoriesImage({required int id}) {
    switch (id) {
      case 7568:
        return AssetsManager.lacimbali;
      case 7544:
        return AssetsManager.franke;
      case 7537:
        return AssetsManager.marzocco;
      case 7536:
        return AssetsManager.johny;
      case 7552:
        return AssetsManager.migel;
      case 7586:
        return AssetsManager.kalerm;
      case 7583:
        return AssetsManager.frucosol;
      case 7562:
        return AssetsManager.mahlkonig;
      case 7570:
        return AssetsManager.anfim;
      case 7564:
        return AssetsManager.animo;
      case 7569:
        return AssetsManager.bonomi;
      case 7577:
        return AssetsManager.chino;
      case 7560:
        return AssetsManager.coffeePlanet;
      case 7531:
        return AssetsManager.eureka;
      case 7590:
        return AssetsManager.lelit;
      case 7597:
        return AssetsManager.nuovaSimonelli;
      case 7596:
        return AssetsManager.vitaminBar;
      default:
        return AssetsManager.noImage;
    }
  }

  ProductModel productModel = ProductModel();
  List<ProductDataModel> products = [];
  void getProduct() {
    emit(ProductsLoadingState());
    SaudiDioHelper.getData(
      path: SaudiApiConstant.productPath,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      for (var item in productModel.data) {
        if (item.categoryId == 7568 ||
            item.categoryId == 7544 ||
            item.categoryId == 7537 ||
            item.categoryId == 7536 ||
            item.categoryId == 7552 ||
            item.categoryId == 7586 ||
            item.categoryId == 7583 ||
            item.categoryId == 7562 ||
            item.categoryId == 7570 ||
            item.categoryId == 7564 ||
            item.categoryId == 7531 ||
            item.categoryId == 7569 ||
            item.categoryId == 7577 ||
            item.categoryId == 7596 ||
            item.categoryId == 7560 ||
            item.categoryId == 7590) {
          products.add(item);
        }
      }
      emit(ProductsSuccessState());
    }).catchError((error) {
      emit(ProductsErrorState());
    });
  }

  var searchController = TextEditingController();
  List<ProductDataModel> productSearch = [];
  void searchInProducts({
    required List<ProductDataModel> productsList,
    required String value,
  }) {
    productSearch = [];
    for (var element in productsList) {
      if (element.name.contains(value)) {
        productSearch.add(element);
      }
    }
    emit(SearchForProductsState());
  }
}
