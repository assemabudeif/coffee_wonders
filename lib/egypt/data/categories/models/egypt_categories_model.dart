class EgyptCategoriesModel {
  final String status;
  final List<EgyptCategoriesDataModel> data;

  EgyptCategoriesModel({
    required this.status,
    required this.data,
  });

  EgyptCategoriesModel copyWith({
    String? status,
    List<EgyptCategoriesDataModel>? data,
  }) =>
      EgyptCategoriesModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptCategoriesModel.fromJson(Map<String, dynamic> json) =>
      EgyptCategoriesModel(
        status: json["status"] ?? "",
        data: json["data"] != null
            ? List<EgyptCategoriesDataModel>.from(
                json["data"].map((x) => EgyptCategoriesDataModel.fromJson(x)))
            : [],
      );
}

class EgyptCategoriesDataModel {
  final int id;
  final dynamic categoryId;
  final String createdAt;
  final String updatedAt;
  final String name;
  final List<Translation> translations;

  EgyptCategoriesDataModel({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.translations,
  });

  EgyptCategoriesDataModel copyWith({
    int? id,
    dynamic categoryId,
    String? createdAt,
    String? updatedAt,
    String? name,
    List<Translation>? translations,
  }) =>
      EgyptCategoriesDataModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        translations: translations ?? this.translations,
      );

  factory EgyptCategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      EgyptCategoriesDataModel(
        id: json["id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        name: json["name"] ?? "",
        translations: json["translations"] != null
            ? List<Translation>.from(
                json["translations"].map((x) => Translation.fromJson(x)))
            : [],
      );
}

class Translation {
  final int id;
  final int categoryId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;

  Translation({
    required this.id,
    required this.categoryId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Translation copyWith({
    int? id,
    int? categoryId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      Translation(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        id: json["id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        locale: json["locale"] ?? "",
        name: json["name"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );
}
