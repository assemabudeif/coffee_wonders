import '/app/constant/egypt_api_constant.dart';
import '/app/services/dio_helper/egypt_dio_helper.dart';
import '/egypt/data/products/models/egypt_all_products_model.dart';
import '/egypt/data/products/models/egypt_product_model.dart';
import 'package:dio/dio.dart';

import 'egypt_product_repository.dart';

class EgyptProductRepositoryImpl implements EgyptProductRepository {
  @override
  Future<EgyptProductModel> getEgyptProduct(String id) async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.showProductPath(id),
      );

      return EgyptProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<EgyptAllProductsModel> getAllEgyptProducts() async {
    try {
      final response = await EgyptDioHelper.getData(
          path: EgyptApiConstant.getAllProductsPath,
          queryParameters: {
            'all_data': '1',
          });

      return EgyptAllProductsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<EgyptAllProductsModel> searchForEgyptProducts(
      String searchValue) async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.searchProductPath,
        queryParameters: {
          'all_data': '1',
        },
        body: {
          'search': searchValue,
        },
      );

      return EgyptAllProductsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
