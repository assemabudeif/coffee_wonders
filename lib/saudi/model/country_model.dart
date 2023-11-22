class CountryModel {
  List<CountryDataModel> data = [];
  CountryModel();
  CountryModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(CountryDataModel.fromJson(element));
    });
  }
}

class CountryDataModel {
  late int id;
  late String name;
  CountryDataModel();
  CountryDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
