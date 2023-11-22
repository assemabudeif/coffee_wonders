import '../models/egypt_all_products_model.dart';
import '/egypt/data/products/models/egypt_product_model.dart';

abstract class EgyptProductRepository {
  Future<EgyptProductModel> getEgyptProduct(String id);
  Future<EgyptAllProductsModel> getAllEgyptProducts();
  Future<EgyptAllProductsModel> searchForEgyptProducts(String searchValue);
}
