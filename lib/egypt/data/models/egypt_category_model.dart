class EgyptCategoriesModel {
  List<EgyptDataCategoriesModel> data = [];
  EgyptCategoriesModel();
  EgyptCategoriesModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(EgyptDataCategoriesModel.fromJson(element));
    });
  }
}

class EgyptDataCategoriesModel {
  late int id;
  late String name;
  EgyptDataCategoriesModel();
  EgyptDataCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
