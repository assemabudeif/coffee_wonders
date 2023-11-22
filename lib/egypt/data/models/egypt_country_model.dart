class EgyptCountryModel {
  List<EgyptCountryDataModel> data = [];
  EgyptCountryModel();
  EgyptCountryModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(EgyptCountryDataModel.fromJson(element));
    });
  }
}

class EgyptCountryDataModel {
  late int id;
  late String name;
  EgyptCountryDataModel();
  EgyptCountryDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
