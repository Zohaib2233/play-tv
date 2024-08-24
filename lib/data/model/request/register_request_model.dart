/// userName : "admin"
/// email : "admin@gmail.com"
/// password : "12345678"
/// socialType : "M"

class RegisterRequestModel {
  RegisterRequestModel({
      String? userName, 
      String? email, 
      String? password, 
      String? socialType,}){
    _userName = userName;
    _email = email;
    _password = password;
    _socialType = socialType;
}

  RegisterRequestModel.fromJson(dynamic json) {
    _userName = json['userName'];
    _email = json['email'];
    _password = json['password'];
    _socialType = json['socialType'];
  }
  String? _userName;
  String? _email;
  String? _password;
  String? _socialType;
RegisterRequestModel copyWith({  String? userName,
  String? email,
  String? password,
  String? socialType,
}) => RegisterRequestModel(  userName: userName ?? _userName,
  email: email ?? _email,
  password: password ?? _password,
  socialType: socialType ?? _socialType,
);
  String? get userName => _userName;
  String? get email => _email;
  String? get password => _password;
  String? get socialType => _socialType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['email'] = _email;
    map['password'] = _password;
    map['socialType'] = _socialType;
    return map;
  }

}