class LoginModel {
  ResultModel result = ResultModel();
  LoginModel();
  LoginModel.fromJson(Map<String, dynamic> json) {
    result = ResultModel.fromJson(
      json["result"],
    );
  }
}

class ResultModel {
  DataModel data = DataModel();

  ResultModel();
  ResultModel.fromJson(Map<String, dynamic> json) {
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
