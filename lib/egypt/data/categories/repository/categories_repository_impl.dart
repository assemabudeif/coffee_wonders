import 'package:coffee_wonders/app/services/dio_helper/egypt_dio_helper.dart';
import 'package:coffee_wonders/egypt/data/categories/models/egypt_categories_model.dart';

import 'package:coffee_wonders/egypt/data/categories/models/egypt_category_brands_model.dart';
import 'package:dio/dio.dart';

import '../../../../app/constant/egypt_api_constant.dart';
import 'categories_repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<EgyptCategoriesModel> getAllCategories() async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.getAllCategoriesPath,
        queryParameters: {
          'all_data': '1',
        },
      );
      if (response.statusCode == 200) {
        return EgyptCategoriesModel.fromJson(response.data);
      } else {
        throw response.data['message'] ?? 'Failed to get categories';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to get categories';
    }
  }

  @override
  Future<EgyptCategoryBrandsModel> getCategoryBrands(String categoryId) async {
    try {
      final response = await EgyptDioHelper.getData(
        path: EgyptApiConstant.showCategoryBrandsPath(categoryId),
      );
      if (response.statusCode == 200) {
        return EgyptCategoryBrandsModel.fromJson(response.data);
      } else {
        throw response.data['message'] ?? 'Failed to get categories';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to get categories';
    }
  }
}
