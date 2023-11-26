class EgyptCategoryBrandsModel {
  final String status;
  final List<EgyptCategoryBrandsDataModel> data;

  EgyptCategoryBrandsModel({
    required this.status,
    required this.data,
  });

  EgyptCategoryBrandsModel copyWith({
    String? status,
    List<EgyptCategoryBrandsDataModel>? data,
  }) =>
      EgyptCategoryBrandsModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptCategoryBrandsModel.fromJson(Map<String, dynamic> json) =>
      EgyptCategoryBrandsModel(
        status: json["status"] ?? "",
        data: json["data"] != null
            ? List<EgyptCategoryBrandsDataModel>.from(json["data"]
                .map((x) => EgyptCategoryBrandsDataModel.fromJson(x)))
            : [],
      );
}

class EgyptCategoryBrandsDataModel {
  final int id;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final String photo;
  final String name;
  final List<Translation> translations;

  EgyptCategoryBrandsDataModel({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.name,
    required this.translations,
  });

  EgyptCategoryBrandsDataModel copyWith({
    int? id,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    String? photo,
    String? name,
    List<Translation>? translations,
  }) =>
      EgyptCategoryBrandsDataModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        photo: photo ?? this.photo,
        name: name ?? this.name,
        translations: translations ?? this.translations,
      );

  factory EgyptCategoryBrandsDataModel.fromJson(Map<String, dynamic> json) =>
      EgyptCategoryBrandsDataModel(
        id: json["id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        photo: json["photo"] ?? "",
        name: json["name"] ?? "",
        translations: json["translations"] != null
            ? List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x)))
            : [],
      );
}

class Translation {
  final int id;
  final int brandId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;

  Translation({
    required this.id,
    required this.brandId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Translation copyWith({
    int? id,
    int? brandId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      Translation(
        id: id ?? this.id,
        brandId: brandId ?? this.brandId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"] ?? 0,
        brandId: json["brand_id"] ?? 0,
        locale: json["locale"] ?? "",
        name: json["name"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );
}
