class PostModel {
  bool? _success;
  List<DataPost>? _data;

  PostModel({bool? success, List<DataPost>? data}) {
    if (success != null) {
      this._success = success;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  List<DataPost>? get data => _data;
  set data(List<DataPost>? data) => _data = data;

  PostModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = <DataPost>[];
      json['data'].forEach((v) {
        _data!.add(new DataPost.fromJson(v));
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

class DataPost {
  int? _id;
  int? _userId;
  String? _name;
  String? _description;
  String? _image;
  int? _likeCount;
  int? _commentCount;
  String? _imageProfile;
  int? _isGaduan;
  String? _createdAt;
  String? _updatedAt;

  DataPost(
      {int? id,
      int? userId,
      String? name,
      String? description,
      String? image,
      int? likeCount,
      int? commentCount,
      String? imageProfile,
      int? isGaduan,
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
    if (description != null) {
      this._description = description;
    }
    if (image != null) {
      this._image = image;
    }
    if (likeCount != null) {
      this._likeCount = likeCount;
    }
    if (commentCount != null) {
      this._commentCount = commentCount;
    }
    if (imageProfile != null) {
      this._imageProfile = imageProfile;
    }
    if (isGaduan != null) {
      this._isGaduan = isGaduan;
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
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get image => _image;
  set image(String? image) => _image = image;
  int? get likeCount => _likeCount;
  set likeCount(int? likeCount) => _likeCount = likeCount;
  int? get commentCount => _commentCount;
  set commentCount(int? commentCount) => _commentCount = commentCount;
  String? get imageProfile => _imageProfile;
  set imageProfile(String? imageProfile) => _imageProfile = imageProfile;
  int? get isGaduan => _isGaduan;
  set isGaduan(int? isGaduan) => _isGaduan = isGaduan;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  DataPost.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _likeCount = json['like_count'];
    _commentCount = json['comment_count'];
    _imageProfile = json['image_profile'];
    _isGaduan = json['is_gaduan'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['description'] = this._description;
    data['image'] = this._image;
    data['like_count'] = this._likeCount;
    data['comment_count'] = this._commentCount;
    data['image_profile'] = this._imageProfile;
    data['is_gaduan'] = this._isGaduan;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
