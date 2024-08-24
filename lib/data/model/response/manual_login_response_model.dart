import 'login_response_model.dart';

/// status : true
/// data : {"userName":"admin","email":"admin@gmail.com","socialType":"M","tokenId":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FkbWluLnBsYXl0djRrLmNvbS9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTY5MzA2MTYwNywiZXhwIjoxNjkzMzIwODA3LCJuYmYiOjE2OTMwNjE2MDcsImp0aSI6IlN4eXc5QVFiaGZ1VGRZOEkiLCJzdWIiOiIyNiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.6cTALY4CNfngZ7eW7sVYzQARmNkd8puex505FqxVPoM","tokenValidity":259200,"isActive":"Y"}
/// msg : "User login successfully"
/// code : 200

class ManualLoginResponseModel {
  ManualLoginResponseModel({
      bool? status, 
      User? login_data,
      String? msg, 
      num? code,}){
    _status = status;
    _data = login_data;
    _msg = msg;
    _code = code;
}

  ManualLoginResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? User.fromJson(json['data']) : null;
    _msg = json['msg'];
    _code = json['code'];
  }
  bool? _status;
  User? _data;
  String? _msg;
  num? _code;
ManualLoginResponseModel copyWith({  bool? status,
  User? data,
  String? msg,
  num? code,
}) => ManualLoginResponseModel(  status: status ?? _status,
  login_data: data ?? _data,
  msg: msg ?? _msg,
  code: code ?? _code,
);
  bool? get status => _status;
  User? get data => _data;
  String? get msg => _msg;
  num? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['msg'] = _msg;
    map['code'] = _code;
    return map;
  }

}



