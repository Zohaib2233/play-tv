/// isUserLike : 1
/// isUserDislike : 0
/// noOfLikes : 1
/// noOfDislikes : 0
/// noOfComments : 1
/// allComments : [{"comment":"Good","name":"maria","image":"https://admin.playtv4k.com/shared_folder/Users/Images/default.png","like":"1","dislike":"0"}]

class AllCommentResponseModel {
  AllCommentResponseModel({
      num? isUserLike, 
      num? isUserDislike, 
      num? noOfLikes, 
      num? noOfDislikes, 
      num? noOfComments, 
      List<AllComments>? allComments,}){
    _isUserLike = isUserLike;
    _isUserDislike = isUserDislike;
    _noOfLikes = noOfLikes;
    _noOfDislikes = noOfDislikes;
    _noOfComments = noOfComments;
    _allComments = allComments;
}

  AllCommentResponseModel.fromJson(dynamic json) {
    _isUserLike = json['isUserLike'];
    _isUserDislike = json['isUserDislike'];
    _noOfLikes = json['noOfLikes'];
    _noOfDislikes = json['noOfDislikes'];
    _noOfComments = json['noOfComments'];
    if (json['allComments'] != null) {
      _allComments = [];
      json['allComments'].forEach((v) {
        _allComments?.add(AllComments.fromJson(v));
      });
    }
  }
  num? _isUserLike;
  num? _isUserDislike;
  num? _noOfLikes;
  num? _noOfDislikes;
  num? _noOfComments;
  List<AllComments>? _allComments;
AllCommentResponseModel copyWith({  num? isUserLike,
  num? isUserDislike,
  num? noOfLikes,
  num? noOfDislikes,
  num? noOfComments,
  List<AllComments>? allComments,
}) => AllCommentResponseModel(  isUserLike: isUserLike ?? _isUserLike,
  isUserDislike: isUserDislike ?? _isUserDislike,
  noOfLikes: noOfLikes ?? _noOfLikes,
  noOfDislikes: noOfDislikes ?? _noOfDislikes,
  noOfComments: noOfComments ?? _noOfComments,
  allComments: allComments ?? _allComments,
);
  num? get isUserLike => _isUserLike;
  num? get isUserDislike => _isUserDislike;
  num? get noOfLikes => _noOfLikes;
  num? get noOfDislikes => _noOfDislikes;
  num? get noOfComments => _noOfComments;
  List<AllComments>? get allComments => _allComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isUserLike'] = _isUserLike;
    map['isUserDislike'] = _isUserDislike;
    map['noOfLikes'] = _noOfLikes;
    map['noOfDislikes'] = _noOfDislikes;
    map['noOfComments'] = _noOfComments;
    if (_allComments != null) {
      map['allComments'] = _allComments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// comment : "Good"
/// name : "maria"
/// image : "https://admin.playtv4k.com/shared_folder/Users/Images/default.png"
/// like : "1"
/// dislike : "0"

class AllComments {
  AllComments({
      String? comment, 
      String? name, 
      String? image, 
      String? like, 
      String? dislike,}){
    _comment = comment;
    _name = name;
    _image = image;
    _like = like;
    _dislike = dislike;
}

  AllComments.fromJson(dynamic json) {
    _comment = json['comment'];
    _name = json['name'];
    _image = json['image'];
    _like = json['like'];
    _dislike = json['dislike'];
  }
  String? _comment;
  String? _name;
  String? _image;
  String? _like;
  String? _dislike;
AllComments copyWith({  String? comment,
  String? name,
  String? image,
  String? like,
  String? dislike,
}) => AllComments(  comment: comment ?? _comment,
  name: name ?? _name,
  image: image ?? _image,
  like: like ?? _like,
  dislike: dislike ?? _dislike,
);
  String? get comment => _comment;
  String? get name => _name;
  String? get image => _image;
  String? get like => _like;
  String? get dislike => _dislike;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comment'] = _comment;
    map['name'] = _name;
    map['image'] = _image;
    map['like'] = _like;
    map['dislike'] = _dislike;
    return map;
  }

}