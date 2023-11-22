// ignore_for_file: prefer_typing_uninitialized_variables

class ProductDetailsModel {
  ProductDetailsDataModel data = ProductDetailsDataModel();
  ProductDetailsModel();
  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    data = ProductDetailsDataModel.fromJson(json["data"]);
  }
}

class ProductDetailsDataModel {
  var description;
  double? priceWithTax;
  ProductDetailsDataModel();
  ProductDetailsDataModel.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    priceWithTax = double.parse(json["tax_string"]
        .toString()
        .split(" ")[1]
        .split("S")[0]
        .replaceAll(",", ""));
  }
}
