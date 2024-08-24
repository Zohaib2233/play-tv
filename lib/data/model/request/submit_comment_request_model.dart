/// channelId : "2"
/// isLike : "1"
/// isDislike : "0"
/// comments : "Good"

class SubmitCommentRequestModel {
  SubmitCommentRequestModel({
      String? channelId, 
      String? isLike, 
      String? isDislike, 
      String? comments,}){
    _channelId = channelId;
    _isLike = isLike;
    _isDislike = isDislike;
    _comments = comments;
}

  SubmitCommentRequestModel.fromJson(dynamic json) {
    _channelId = json['channelId'];
    _isLike = json['isLike'];
    _isDislike = json['isDislike'];
    _comments = json['comments'];
  }
  String? _channelId;
  String? _isLike;
  String? _isDislike;
  String? _comments;
SubmitCommentRequestModel copyWith({  String? channelId,
  String? isLike,
  String? isDislike,
  String? comments,
}) => SubmitCommentRequestModel(  channelId: channelId ?? _channelId,
  isLike: isLike ?? _isLike,
  isDislike: isDislike ?? _isDislike,
  comments: comments ?? _comments,
);
  String? get channelId => _channelId;
  String? get isLike => _isLike;
  String? get isDislike => _isDislike;
  String? get comments => _comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['channelId'] = _channelId;
    map['isLike'] = _isLike;
    map['isDislike'] = _isDislike;
    map['comments'] = _comments;
    return map;
  }

}