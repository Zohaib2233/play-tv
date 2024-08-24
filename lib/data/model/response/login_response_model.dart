/// status : true
/// data : {"userName":"maria","email":"muzaffar","socialType":"G","tokenId":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FkbWluLnBsYXl0djRrLmNvbS9hcGkvYXV0aC91c2VyIiwiaWF0IjoxNjg5OTMyODgzLCJleHAiOjE2OTAxOTIwODMsIm5iZiI6MTY4OTkzMjg4MywianRpIjoiM1ZkYUlPdjJmM0R5RlpwSSIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.hoZJYeIIu7PdTY5VMJJnzimBSjvWzXw3DxJ9_EzyANw","tokenValidity":259200,"isActive":"Y"}
/// msg : "User Logged In Successfully"
/// code : 200

class LoginResponseModel {
  LoginResponseModel({
      bool? status, 
      User? user,
      String? msg, 
      num? code,}){
    _status = status;
    _user = user;
    _msg = msg;
    _code = code;
}

  LoginResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _user = json['data'] != null ? User.fromJson(json['data']) : null;
    _msg = json['msg'];
    _code = json['code'];
  }
  bool? _status;
  User? _user;
  String? _msg;
  num? _code;
LoginResponseModel copyWith({  bool? status,
  User? data,
  String? msg,
  num? code,
}) => LoginResponseModel(  status: status ?? _status,
  user: data ?? _user,
  msg: msg ?? _msg,
  code: code ?? _code,
);
  bool? get status => _status;
  User? get data => _user;
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

/// userName : "maria"
/// email : "muzaffar"
/// socialType : "G"
/// tokenId : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FkbWluLnBsYXl0djRrLmNvbS9hcGkvYXV0aC91c2VyIiwiaWF0IjoxNjg5OTMyODgzLCJleHAiOjE2OTAxOTIwODMsIm5iZiI6MTY4OTkzMjg4MywianRpIjoiM1ZkYUlPdjJmM0R5RlpwSSIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.hoZJYeIIu7PdTY5VMJJnzimBSjvWzXw3DxJ9_EzyANw"
/// tokenValidity : 259200
/// isActive : "Y"

class User {
  User({
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

  User.fromJson(dynamic json) {
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
User copyWith({  String? userName,
  String? email,
  String? socialType,
  String? tokenId,
  num? tokenValidity,
  String? isActive,
}) => User(  userName: userName ?? _userName,
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