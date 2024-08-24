/// socialTokenId : "721637y12i3hekjwjewqb"
/// socialType : "G"
/// userName : ""
/// email : ""

class LoginRequestModel {
  LoginRequestModel({
      String? socialTokenId, 
      String? socialType, 
      String? userName, 
      String? email,}){
    _socialTokenId = socialTokenId;
    _socialType = socialType;
    _userName = userName;
    _email = email;
}

  LoginRequestModel.fromJson(dynamic json) {
    _socialTokenId = json['socialTokenId'];
    _socialType = json['socialType'];
    _userName = json['userName'];
    _email = json['email'];
  }
  String? _socialTokenId;
  String? _socialType;
  String? _userName;
  String? _email;
LoginRequestModel copyWith({  String? socialTokenId,
  String? socialType,
  String? userName,
  String? email,
}) => LoginRequestModel(  socialTokenId: socialTokenId ?? _socialTokenId,
  socialType: socialType ?? _socialType,
  userName: userName ?? _userName,
  email: email ?? _email,
);
  String? get socialTokenId => _socialTokenId;
  String? get socialType => _socialType;
  String? get userName => _userName;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['socialTokenId'] = _socialTokenId;
    map['socialType'] = _socialType;
    map['userName'] = _userName;
    map['email'] = _email;
    return map;
  }

}