class EgyptBrandProductsModel {
  final String status;
  final Data data;

  EgyptBrandProductsModel({
    required this.status,
    required this.data,
  });

  EgyptBrandProductsModel copyWith({
    String? status,
    Data? data,
  }) =>
      EgyptBrandProductsModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptBrandProductsModel.fromJson(Map<String, dynamic> json) =>
      EgyptBrandProductsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final String photo;
  final String name;
  final List<Product> products;
  final List<DataTranslation> translations;

  Data({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.name,
    required this.products,
    required this.translations,
  });

  Data copyWith({
    int? id,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    String? photo,
    String? name,
    List<Product>? products,
    List<DataTranslation>? translations,
  }) =>
      Data(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        photo: photo ?? this.photo,
        name: name ?? this.name,
        products: products ?? this.products,
        translations: translations ?? this.translations,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        photo: json["photo"],
        name: json["name"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        translations: List<DataTranslation>.from(
            json["translations"].map((x) => DataTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "photo": photo,
        "name": name,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class Product {
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
  final List<dynamic> stocks;
  final List<ProductTranslation> translations;

  Product({
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
    required this.stocks,
    required this.translations,
  });

  Product copyWith({
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
    List<dynamic>? stocks,
    List<ProductTranslation>? translations,
  }) =>
      Product(
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
        stocks: stocks ?? this.stocks,
        translations: translations ?? this.translations,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        stocks: List<dynamic>.from(json["stocks"].map((x) => x)),
        translations: List<ProductTranslation>.from(
            json["translations"].map((x) => ProductTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "serial": serial,
        "price": price,
        "tax": tax,
        "discount": discount,
        "discount_type": discountType,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "brand_id": brandId,
        "total": total,
        "discount_type_text": discountTypeText,
        "stock": stock,
        "name": name,
        "description": description,
        "stocks": List<dynamic>.from(stocks.map((x) => x)),
        "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
      };
}

class ProductTranslation {
  final int id;
  final int productId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String description;

  ProductTranslation({
    required this.id,
    required this.productId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  ProductTranslation copyWith({
    int? id,
    int? productId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
    String? description,
  }) =>
      ProductTranslation(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
      );

  factory ProductTranslation.fromJson(Map<String, dynamic> json) =>
      ProductTranslation(
        id: json["id"],
        productId: json["product_id"],
        locale: json["locale"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "locale": locale,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "description": description,
      };
}

class DataTranslation {
  final int id;
  final int brandId;
  final String locale;
  final String name;
  final String createdAt;
  final String updatedAt;

  DataTranslation({
    required this.id,
    required this.brandId,
    required this.locale,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  DataTranslation copyWith({
    int? id,
    int? brandId,
    String? locale,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataTranslation(
        id: id ?? this.id,
        brandId: brandId ?? this.brandId,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataTranslation.fromJson(Map<String, dynamic> json) =>
      DataTranslation(
        id: json["id"],
        brandId: json["brand_id"],
        locale: json["locale"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "locale": locale,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
