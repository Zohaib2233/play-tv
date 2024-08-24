/// status : false
/// data : {}
/// msg : "Unauthorized request"
/// code : 401

class ErrorResponse {
  ErrorResponse({
    bool? status,
    dynamic data,
    String? msg,
    num? code,
  }) {
    _status = status;
    _data = data;
    _msg = msg;
    _code = code;
  }

  ErrorResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
    _msg = json['msg'];
    _code = json['code'];
  }

  bool? _status;
  dynamic _data;
  String? _msg;
  num? _code;

  ErrorResponse copyWith({
    bool? status,
    dynamic data,
    String? msg,
    num? code,
  }) =>
      ErrorResponse(
        status: status ?? _status,
        data: data ?? _data,
        msg: msg ?? _msg,
        code: code ?? _code,
      );

  bool? get status => _status;

  dynamic get data => _data;

  String? get msg => _msg;

  num? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['data'] = _data;
    map['msg'] = _msg;
    map['code'] = _code;
    return map;
  }
}