// ignore_for_file: prefer_typing_uninitialized_variables

class ProductModel {
  List<ProductDataModel> data = [];
  ProductModel();
  ProductModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(ProductDataModel.fromJson(element));
    });
  }
}

class ProductDataModel {
  late int id;
  late var name;
  late int categoryId;
  late var categoryName;
  late var defaultCode;
  late double salePrice;
  late double quantity;
  late var image;
  ProductDataModel();
  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    categoryId = json["category_id"];
    categoryName = json["category_name"];
    defaultCode = json["default_code"];
    salePrice = json["sale_price"];
    quantity = json["quantity"];
    image = json["image"];
  }
}
