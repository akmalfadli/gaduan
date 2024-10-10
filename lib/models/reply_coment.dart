class ReplyCommentModel {
  bool? _success;
  List<DataReplyComment>? _data;

  ReplyCommentModel({bool? success, List<DataReplyComment>? data}) {
    if (success != null) {
      this._success = success;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  List<DataReplyComment>? get data => _data;
  set data(List<DataReplyComment>? data) => _data = data;

  ReplyCommentModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = <DataReplyComment>[];
      json['data'].forEach((v) {
        _data!.add(new DataReplyComment.fromJson(v));
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

class DataReplyComment {
  int? _id;
  int? _userId;
  String? _name;
  String? _imageProfile;
  String? _content;
  String? _createdAt;
  String? _updatedAt;

  DataReplyComment(
      {int? id,
      int? userId,
      String? name,
      String? imageProfile,
      String? content,
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
    if (content != null) {
      this._content = content;
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
  String? get content => _content;
  set content(String? content) => _content = content;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  DataReplyComment.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _imageProfile = json['image_profile'];
    _content = json['content'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['image_profile'] = this._imageProfile;
    data['content'] = this._content;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
