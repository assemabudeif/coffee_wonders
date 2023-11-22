class EgyptBrandModel {
  final String status;
  final List<EgyptBrandDataModel> data;

  EgyptBrandModel({
    required this.status,
    required this.data,
  });

  EgyptBrandModel copyWith({
    String? status,
    List<EgyptBrandDataModel>? data,
  }) =>
      EgyptBrandModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptBrandModel.fromJson(Map<String, dynamic> json) =>
      EgyptBrandModel(
        status: json["status"] ?? "",
        data:
            // json["data"] == null
            //     ?
            List<EgyptBrandDataModel>.from(
                json["data"].map((x) => EgyptBrandDataModel.fromJson(x))),
        // : [],
      );
}

class EgyptBrandDataModel {
  final int id;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final String photo;
  final String name;
  final List<Translation> translations;

  EgyptBrandDataModel({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.name,
    required this.translations,
  });

  EgyptBrandDataModel copyWith({
    int? id,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    String? photo,
    String? name,
    List<Translation>? translations,
  }) =>
      EgyptBrandDataModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        photo: photo ?? this.photo,
        name: name ?? this.name,
        translations: translations ?? this.translations,
      );

  factory EgyptBrandDataModel.fromJson(Map<String, dynamic> json) =>
      EgyptBrandDataModel(
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
