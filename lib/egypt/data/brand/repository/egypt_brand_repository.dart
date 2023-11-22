import '../models/egypt_brand_model.dart';
import '../models/egypt_brand_products_model.dart';

abstract class EgyptBrandRepository {
  Future<EgyptBrandModel> getAllBrands();
  Future<EgyptBrandDataModel> showBrands(String id);
  Future<EgyptBrandProductsModel> getBrandProducts(String id);
}
