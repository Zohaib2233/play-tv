/// keyword : "rt"

class SearchChannelRequestModel {
  SearchChannelRequestModel({
      String? keyword,}){
    _keyword = keyword;
}

  SearchChannelRequestModel.fromJson(dynamic json) {
    _keyword = json['keyword'];
  }
  String? _keyword;
SearchChannelRequestModel copyWith({  String? keyword,
}) => SearchChannelRequestModel(  keyword: keyword ?? _keyword,
);
  String? get keyword => _keyword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['keyword'] = _keyword;
    return map;
  }

}