class EgyptProductModel {
  final String status;
  final EgyptProductDataModel data;

  EgyptProductModel({
    required this.status,
    required this.data,
  });

  EgyptProductModel copyWith({
    String? status,
    EgyptProductDataModel? data,
  }) =>
      EgyptProductModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptProductModel.fromJson(Map<String, dynamic> json) =>
      EgyptProductModel(
        status: json["status"],
        data: EgyptProductDataModel.fromJson(json["data"]),
      );
}

class EgyptProductDataModel {
  final int id;
  final String photo;
  final String serial;
  final int price;
  final int tax;
  final int discount;
  final String discountType;
  final String createdAt;
  final String updatedAt;
  final int brandId;
  final int total;
  final String discountTypeText;
  final int stock;
  final String name;
  final String description;
  final Brand? brand;
  final List<DataTranslation> translations;

  EgyptProductDataModel({
    required this.id,
    required this.photo,
    required this.serial,
    required this.price,
    required this.tax,
    required this.discount,
    required this.discountType,
    required this.createdAt,
    required this.updatedAt,
    required this.brandId,
    required this.total,
    required this.discountTypeText,
    required this.stock,
    required this.name,
    required this.description,
    required this.brand,
    required this.translations,
  });

  EgyptProductDataModel copyWith({
    int? id,
    String? photo,
    String? serial,
    int? price,
    int? tax,
    int? discount,
    String? discountType,
    String? createdAt,
    String? updatedAt,
    int? brandId,
    int? total,
    String? discountTypeText,
    int? stock,
    String? name,
    String? description,
    Brand? brand,
    List<DataTranslation>? translations,
  }) =>
      EgyptProductDataModel(
        id: id ?? this.id,
        photo: photo ?? this.photo,
        serial: serial ?? this.serial,
        price: price ?? this.price,
        tax: tax ?? this.tax,
        discount: discount ?? this.discount,
        discountType: discountType ?? this.discountType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        brandId: brandId ?? this.brandId,
        total: total ?? this.total,
        discountTypeText: discountTypeText ?? this.discountTypeText,
        stock: stock ?? this.stock,
        name: name ?? this.name,
        description: description ?? this.description,
        brand: brand ?? this.brand,
        translations: translations ?? this.translations,
      );

  factory EgyptProductDataModel.fromJson(Map<String, dynamic> json) =>
      EgyptProductDataModel(
        id: json["id"],
        photo: json["photo"],
        serial: json["serial"],
        price: json["price"],
        tax: json["tax"],
        discount: json["discount"],
        discountType: json["discount_type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        brandId: json["brand_id"],
        total: json["total"],
        discountTypeText: json["discount_type_text"],
        stock: json["stock"],
        name: json["name"],
        description: json["description"],
        brand: json["brand"] != null ? Brand.fromJson(json["brand"]) : null,
        translations: json["translations"] != null
            ? List<DataTranslation>.from(
                json["translations"].map((x) => DataTranslation.fromJson(x)))
            : [],
      );
}

class Brand {
  final int id;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final String photo;
  final String name;
  final Category category;
  final List<BrandTranslation> translations;

  Brand({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.name,
    required this.category,
    required this.translations,
  });

  Brand copyWith({
    int? id,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    String? photo,
    String? name,
    Category? category,
    List<BrandTranslation>? translations,
  }) =>
      Brand(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        photo: photo ?? this.photo,
        name: name ?? this.name,
        category: category ?? this.category,
        translations: translations ?? this.translations,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        photo: json["photo"],
        name: json["name"],
        category: Category.fromJson(json["category"]),
        translations: List<BrandTranslation>.from(
            json["translations"].map((x) => BrandTranslation.fromJson(x))),
      );
}

class Category {
  final int id;
  final dynamic categoryId;
  final String createdAt;
  final String updatedAt;
  final String name;
  final dynamic parent;
  final List<CategoryTranslation> translations;

  Category({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.parent,
    required this.translations,
  });

  Category copyWith({
    int? id,
    dynamic categoryId,
    String? createdAt,
    String? updatedAt,
    String? name,
    dynamic parent,
    List<CategoryTranslation>? translations,
  }) =>
      Category(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        parent: parent ?? this.parent,
        translations: translations ?? this.translations,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        name: json["name"],
        parent: json["parent"],
        translations: List<CategoryTranslation>.from(
            json["translations"].map((x) => CategoryTranslation.fromJson(x))),
      );
}

class CategoryTranslation {
  final int id;
  final int categoryId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;

  CategoryTranslation({
    required this.id,
    required this.categoryId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryTranslation copyWith({
    int? id,
    int? categoryId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      CategoryTranslation(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CategoryTranslation.fromJson(Map<String, dynamic> json) =>
      CategoryTranslation(
        id: json["id"],
        categoryId: json["category_id"],
        locale: json["locale"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class BrandTranslation {
  final int id;
  final int brandId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;

  BrandTranslation({
    required this.id,
    required this.brandId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  BrandTranslation copyWith({
    int? id,
    int? brandId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      BrandTranslation(
        id: id ?? this.id,
        brandId: brandId ?? this.brandId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory BrandTranslation.fromJson(Map<String, dynamic> json) =>
      BrandTranslation(
        id: json["id"],
        brandId: json["brand_id"],
        locale: json["locale"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class DataTranslation {
  final int id;
  final int productId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String description;

  DataTranslation({
    required this.id,
    required this.productId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  DataTranslation copyWith({
    int? id,
    int? productId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
    String? description,
  }) =>
      DataTranslation(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
      );

  factory DataTranslation.fromJson(Map<String, dynamic> json) =>
      DataTranslation(
        id: json["id"],
        productId: json["product_id"],
        locale: json["locale"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        description: json["description"],
      );
}
