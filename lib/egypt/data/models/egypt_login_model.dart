class EgyptLoginModel {
  EgyptResultModel result = EgyptResultModel();
  EgyptLoginModel();
  EgyptLoginModel.fromJson(Map<String, dynamic> json) {
    result = EgyptResultModel.fromJson(
      json["result"],
    );
  }
}

class EgyptResultModel {
  DataModel data = DataModel();

  EgyptResultModel();
  EgyptResultModel.fromJson(Map<String, dynamic> json) {
    data = DataModel.fromJson(
      json["data"],
    );
  }
}

class DataModel {
  late String token;
  DataModel();
  DataModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
  }
}
