import 'dart:developer';

import '/app/constant/egypt_api_constant.dart';
import '/app/services/dio_helper/egypt_dio_helper.dart';

import 'package:dio/dio.dart';

import '../models/egypt_brand_model.dart';
import '../models/egypt_brand_products_model.dart';
import 'egypt_brand_repository.dart';

class EgyptBrandRepositoryImpl extends EgyptBrandRepository {
  @override
  Future<EgyptBrandModel> getAllBrands() async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.getAllBrandsPath,
        queryParameters: {
          'all_data': '1',
        },
      );
      if (response.statusCode == 200 && response.data != null) {
        log(response.data.toString());
        return EgyptBrandModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data!');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<EgyptBrandProductsModel> getBrandProducts(String id) async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.getBrandProductsPath(id),
        // queryParameters: {
        //   'all_data': '1',
        // },
      );

      log("Products Model: ${response.data.toString()}");

      if (response.statusCode == 200) {
        return EgyptBrandProductsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data!');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<EgyptBrandDataModel> showBrands(String id) async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.showBrandPath(id),
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        return EgyptBrandDataModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load data!');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
