import 'package:coffee_wonders/app/resources/constants_manager.dart';

class EgyptApiConstant {
  static const String baseUrl = "https://pos-api.lineerp.live/";

  /// Categories Paths
  static String getAllCategoriesPath =
      "${AppConstants.appLanguage}/api/categories";

  static String showCategoryBrandsPath(String categoryId) =>
      "${AppConstants.appLanguage}/api/categories/brands/$categoryId";

  /// Auth Paths
  static String registerPath =
      '${AppConstants.appLanguage}/api/auth/client/register';
  static String loginPath = '${AppConstants.appLanguage}/api/auth/client/login';
  static String logoutPath =
      '${AppConstants.appLanguage}/api/auth/client/logout';
  static String profilePath =
      '${AppConstants.appLanguage}/pi/auth/client/profile';

  /// Brands Paths
  static String getAllBrandsPath = "${AppConstants.appLanguage}/api/brands";
  static String showBrandPath(String brandId) =>
      "${AppConstants.appLanguage}/api/brands/$brandId";
  static String getBrandProductsPath(String brandId) =>
      "${AppConstants.appLanguage}/api/brand/products/$brandId";

  /// Products Paths
  static String getAllProductsPath = "${AppConstants.appLanguage}/api/products";

  static String showProductPath(String productId) =>
      "${AppConstants.appLanguage}/api/products/$productId";
  static String searchProductPath =
      "${AppConstants.appLanguage}/api/product/search";

  /// Orders Paths
  static String createNewOrderPath = "${AppConstants.appLanguage}/api/orders";

  // static const String loginPath = "/api/authenticate";
  // static const String categoriesPath = "/api/category";
  // static const String productPath = "/api/all/products";
  // static String productDetailsPath({
  //   required int id,
  // }) =>
  //     "/api/product/$id";
  // static const String countryPath = "/api/country";
  // static String statePath({required int id}) => "/api/state/country/$id";
  // static const String checkoutPath = "/api/sale/order";
  // static String productsByCategoryId({required int id}) =>
  //     "/api/all/category/products/$id";
}
