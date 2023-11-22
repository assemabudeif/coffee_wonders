import '/app/constant/saudi_api_constant.dart';
import '/app/services/dio_helper/saudi_dio_helper.dart';
import '/app/services/shared_prefrences/cache_helper.dart';
import '/saudi/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/products/controller/states.dart';

class ProductsBloc extends Cubit<ProductsStates> {
  ProductsBloc() : super(ProductInitState());
  static ProductsBloc get(context) => BlocProvider.of(context);

  ProductModel productModel = ProductModel();
  void getProductsByCategoryId({required int id}) {
    emit(ProductLoadingState());
    SaudiDioHelper.getData(
      path: SaudiApiConstant.productsByCategoryId(id: id),
      token: CacheHelper.getData(key: SharedKey.token),
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(ProductSuccessState());
    }).catchError((error) {
      emit(ProductErrorState());
    });
  }
}
