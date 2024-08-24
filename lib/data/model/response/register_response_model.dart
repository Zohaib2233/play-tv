/// status : true
/// data : {"userName":"admin","email":"admin@gmail.com","socialType":"M","tokenId":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FkbWluLnBsYXl0djRrLmNvbS9hcGkvYXV0aC9yZWdpc3RlciIsImlhdCI6MTY5Mjk3NDE1MSwiZXhwIjoxNjkzMjMzMzUxLCJuYmYiOjE2OTI5NzQxNTEsImp0aSI6ImxScDVuOHdCSWZKQkJ2c2wiLCJzdWIiOiIyNiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Rgtcl2LYz0VzmA43-3O6JpTLBUgfMLiq2P-CJdcnC_Q","tokenValidity":259200,"isActive":"Y"}
/// msg : "User registered successfully"
/// code : 200

class RegisterResponseModel {
  RegisterResponseModel({
      bool? status, 
      UserData? user,
      String? msg, 
      num? code,}){
    _status = status;
    _user = user;
    _msg = msg;
    _code = code;
}

  RegisterResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _user = json['data'] != null ? UserData.fromJson(json['data']) : null;
    _msg = json['msg'];
    _code = json['code'];
  }
  bool? _status;
  UserData? _user;
  String? _msg;
  num? _code;
RegisterResponseModel copyWith({  bool? status,
  UserData? data,
  String? msg,
  num? code,
}) => RegisterResponseModel(  status: status ?? _status,
  user: data ?? _user,
  msg: msg ?? _msg,
  code: code ?? _code,
);
  bool? get status => _status;
  UserData? get data => _user;
  String? get msg => _msg;
  num? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_user != null) {
      map['data'] = _user?.toJson();
    }
    map['msg'] = _msg;
    map['code'] = _code;
    return map;
  }

}

/// userName : "admin"
/// email : "admin@gmail.com"
/// socialType : "M"
/// tokenId : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FkbWluLnBsYXl0djRrLmNvbS9hcGkvYXV0aC9yZWdpc3RlciIsImlhdCI6MTY5Mjk3NDE1MSwiZXhwIjoxNjkzMjMzMzUxLCJuYmYiOjE2OTI5NzQxNTEsImp0aSI6ImxScDVuOHdCSWZKQkJ2c2wiLCJzdWIiOiIyNiIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Rgtcl2LYz0VzmA43-3O6JpTLBUgfMLiq2P-CJdcnC_Q"
/// tokenValidity : 259200
/// isActive : "Y"

class UserData {
  UserData({
      String? userName, 
      String? email, 
      String? socialType, 
      String? tokenId, 
      num? tokenValidity, 
      String? isActive,}){
    _userName = userName;
    _email = email;
    _socialType = socialType;
    _tokenId = tokenId;
    _tokenValidity = tokenValidity;
    _isActive = isActive;
}

  UserData.fromJson(dynamic json) {
    _userName = json['userName'];
    _email = json['email'];
    _socialType = json['socialType'];
    _tokenId = json['tokenId'];
    _tokenValidity = json['tokenValidity'];
    _isActive = json['isActive'];
  }
  String? _userName;
  String? _email;
  String? _socialType;
  String? _tokenId;
  num? _tokenValidity;
  String? _isActive;
UserData copyWith({  String? userName,
  String? email,
  String? socialType,
  String? tokenId,
  num? tokenValidity,
  String? isActive,
}) => UserData(  userName: userName ?? _userName,
  email: email ?? _email,
  socialType: socialType ?? _socialType,
  tokenId: tokenId ?? _tokenId,
  tokenValidity: tokenValidity ?? _tokenValidity,
  isActive: isActive ?? _isActive,
);
  String? get userName => _userName;
  String? get email => _email;
  String? get socialType => _socialType;
  String? get tokenId => _tokenId;
  num? get tokenValidity => _tokenValidity;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['email'] = _email;
    map['socialType'] = _socialType;
    map['tokenId'] = _tokenId;
    map['tokenValidity'] = _tokenValidity;
    map['isActive'] = _isActive;
    return map;
  }

}