import '../models/egypt_categories_model.dart';
import '../models/egypt_category_brands_model.dart';

abstract class CategoriesRepository {
  Future<EgyptCategoriesModel> getAllCategories();

  Future<EgyptCategoryBrandsModel> getCategoryBrands(String categoryId);
}
