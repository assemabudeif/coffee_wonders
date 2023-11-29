import 'package:equatable/equatable.dart';

class EgyptRegisterModel extends Equatable {
  final String status;
  final Data data;

  const EgyptRegisterModel({
    required this.status,
    required this.data,
  });

  EgyptRegisterModel copyWith({
    String? status,
    Data? data,
  }) =>
      EgyptRegisterModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory EgyptRegisterModel.fromJson(Map<String, dynamic> json) =>
      EgyptRegisterModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  @override
  List<Object> get props => [status, data];
}

class Data extends Equatable {
  final String name;
  final String email;
  final String updatedAt;
  final String createdAt;
  final int id;
  final String token;

  const Data({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.token,
  });

  Data copyWith({
    String? name,
    String? email,
    String? updatedAt,
    String? createdAt,
    int? id,
    String? token,
  }) =>
      Data(
        name: name ?? this.name,
        email: email ?? this.email,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        token: token ?? this.token,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
        token: json["token"],
      );

  @override
  List<Object> get props => [name, email, updatedAt, createdAt, id, token];
}
