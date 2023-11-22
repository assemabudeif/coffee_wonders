import 'egypt_product_model.dart';

class EgyptAllProductsModel {
  final String status;
  final List<EgyptProductDataModel> data;

  EgyptAllProductsModel({
    required this.status,
    required this.data,
  });

  EgyptAllProductsModel copyWith({
    String? status,
    List<EgyptProductDataModel>? data,
  }) =>
      EgyptAllProductsModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptAllProductsModel.fromJson(Map<String, dynamic> json) =>
      EgyptAllProductsModel(
        status: json["status"],
        data: List<EgyptProductDataModel>.from(
            json["data"].map((x) => EgyptProductDataModel.fromJson(x))),
      );
}
