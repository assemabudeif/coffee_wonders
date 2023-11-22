class CategoriesModel {
  List<DataCategoriesModel> data = [];
  CategoriesModel();
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(DataCategoriesModel.fromJson(element));
    });
  }
}

class DataCategoriesModel {
  late int id;
  late String name;
  DataCategoriesModel();
  DataCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
