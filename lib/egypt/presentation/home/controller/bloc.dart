import '../../../data/products/models/egypt_product_model.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/app/resources/assets_manager.dart';
import 'states.dart';

class EgyptHomeBloc extends Cubit<EgyptHomeStates> {
  EgyptHomeBloc() : super(HomeInitState());
  static EgyptHomeBloc get(context) => BlocProvider.of(context);
  List<String> banners = [
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner3,
  ];
  var searchController = TextEditingController();
  List<EgyptProductDataModel> productSearch = [];
  void searchInProducts({
    required List<EgyptProductDataModel> productsList,
    required String value,
  }) {
    // productSearch = [];
    // for (var element in productsList) {
    //   if (element.name.contains(value)) {
    //     productSearch.add(element);
    //   }
    // }
    // emit(SearchForProductsState());
  }
}
