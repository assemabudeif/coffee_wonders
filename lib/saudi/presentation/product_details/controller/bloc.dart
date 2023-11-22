import '/app/constant/saudi_api_constant.dart';
import '/app/services/dio_helper/saudi_dio_helper.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import '/saudi/presentation/product_details/controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/product_details_model.dart';

class ProductDetailsBloc extends Cubit<ProductDetailsStates> {
  ProductDetailsBloc() : super(ProductDetailsInitState());
  static ProductDetailsBloc get(context) => BlocProvider.of(context);

  ProductDetailsModel productDetailsModel = ProductDetailsModel();
  void getProductDetials({
    required int id,
  }) {
    emit(ProductDetailsLoadingState());
    SaudiDioHelper.getData(
        path: SaudiApiConstant.productDetailsPath(id: id),
        token: CacheHelper.getData(
          key: SharedKey.token,
        )).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);

      emit(ProductDetailsSuccessState());
    }).catchError((error) {
      emit(ProductDetailsErrorState());
    });
  }

  int counter = 1;
  int incrementProductCounter() {
    ++counter;

    return counter;
  }

  int decrementProductCounter() {
    --counter;
    if (counter < 1) {
      counter = 1;
    }
    return counter;
  }
}
