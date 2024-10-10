class CommentModel {
  bool? _success;
  List<DataComment>? _data;

  CommentModel({bool? success, List<DataComment>? data}) {
    if (success != null) {
      this._success = success;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  List<DataComment>? get data => _data;
  set data(List<DataComment>? data) => _data = data;

  CommentModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = <DataComment>[];
      json['data'].forEach((v) {
        _data!.add(new DataComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataComment {
  int? _id;
  int? _userId;
  String? _name;
  String? _imageProfile;
  String? _comment;
  int? _repliesCount;
  String? _createdAt;
  String? _updatedAt;

  DataComment(
      {int? id,
      int? userId,
      String? name,
      String? imageProfile,
      String? comment,
      int? repliesCount,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (name != null) {
      this._name = name;
    }
    if (imageProfile != null) {
      this._imageProfile = imageProfile;
    }
    if (comment != null) {
      this._comment = comment;
    }
    if (repliesCount != null) {
      this._repliesCount = repliesCount;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get imageProfile => _imageProfile;
  set imageProfile(String? imageProfile) => _imageProfile = imageProfile;
  String? get comment => _comment;
  set comment(String? comment) => _comment = comment;
  int? get repliesCount => _repliesCount;
  set repliesCount(int? repliesCount) => _repliesCount = repliesCount;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  DataComment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _imageProfile = json['image_profile'];
    _comment = json['comment'];
    _repliesCount = json['replies_count'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['image_profile'] = this._imageProfile;
    data['comment'] = this._comment;
    data['replies_count'] = this._repliesCount;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
