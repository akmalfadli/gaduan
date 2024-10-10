class UserModel {
  bool? _success;
  Token? _token;
  User? _user;

  UserModel({bool? success, Token? token, User? user}) {
    if (success != null) {
      this._success = success;
    }
    if (token != null) {
      this._token = token;
    }
    if (user != null) {
      this._user = user;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  Token? get token => _token;
  set token(Token? token) => _token = token;
  User? get user => _user;
  set user(User? user) => _user = user;

  UserModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._token != null) {
      data['token'] = this._token!.toJson();
    }
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    return data;
  }
}

class Token {
  String? _token;

  Token({String? token}) {
    if (token != null) {
      this._token = token;
    }
  }

  String? get token => _token;
  set token(String? token) => _token = token;

  Token.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    return data;
  }
}

class User {
  int? _id;
  String? _name;
  String? _username;
  String? _email;
  String? _emailVerifiedAt;
  int? _jenisKelamin;
  String? _tanggalLahir;
  String? _bio;
  String? _nomorHp;
  String? _alamat;
  String? _desa;
  String? _kecamatan;
  String? _kabupaten;
  String? _imageProfile;
  int? _isGaduan;
  String? _createdAt;
  String? _updatedAt;

  User(
      {int? id,
      String? name,
      String? username,
      String? email,
      Null? emailVerifiedAt,
      Null? jenisKelamin,
      String? tanggalLahir,
      String? bio,
      String? nomorHp,
      String? alamat,
      String? desa,
      String? kecamatan,
      String? kabupaten,
      String? imageProfile,
      int? isGaduan,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (username != null) {
      this._username = username;
    }
    if (email != null) {
      this._email = email;
    }
    if (emailVerifiedAt != null) {
      this._emailVerifiedAt = emailVerifiedAt;
    }
    if (jenisKelamin != null) {
      this._jenisKelamin = jenisKelamin;
    }
    if (tanggalLahir != null) {
      this._tanggalLahir = tanggalLahir;
    }
    if (bio != null) {
      this._bio = bio;
    }
    if (nomorHp != null) {
      this._nomorHp = nomorHp;
    }
    if (alamat != null) {
      this._alamat = alamat;
    }
    if (desa != null) {
      this._desa = desa;
    }
    if (kecamatan != null) {
      this._kecamatan = kecamatan;
    }
    if (kabupaten != null) {
      this._kabupaten = kabupaten;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get emailVerifiedAt => _emailVerifiedAt;
  set emailVerifiedAt(String? emailVerifiedAt) =>
      _emailVerifiedAt = emailVerifiedAt;
  int? get jenisKelamin => _jenisKelamin;
  set jenisKelamin(int? jenisKelamin) => _jenisKelamin = jenisKelamin;
  String? get tanggalLahir => _tanggalLahir;
  set tanggalLahir(String? tanggalLahir) => _tanggalLahir = tanggalLahir;
  String? get bio => _bio;
  set bio(String? bio) => _bio = bio;
  String? get nomorHp => _nomorHp;
  set nomorHp(String? nomorHp) => _nomorHp = nomorHp;
  String? get alamat => _alamat;
  set alamat(String? alamat) => _alamat = alamat;
  String? get desa => _desa;
  set desa(String? desa) => _desa = desa;
  String? get kecamatan => _kecamatan;
  set kecamatan(String? kecamatan) => _kecamatan = kecamatan;
  String? get kabupaten => _kabupaten;
  set kabupaten(String? kabupaten) => _kabupaten = kabupaten;
  String? get imageProfile => _imageProfile;
  set imageProfile(String? imageProfile) => _imageProfile = imageProfile;
  int? get isGaduan => _isGaduan;
  set isGaduan(int? isGaduan) => _isGaduan = isGaduan;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _jenisKelamin = json['jenis_kelamin'];
    _tanggalLahir = json['tanggal_lahir'];
    _bio = json['bio'];
    _nomorHp = json['nomor_hp'];
    _alamat = json['alamat'];
    _desa = json['desa'];
    _kecamatan = json['kecamatan'];
    _kabupaten = json['kabupaten'];
    _imageProfile = json['image_profile'];
    _isGaduan = json['is_gaduan'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['username'] = this._username;
    data['email'] = this._email;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['jenis_kelamin'] = this._jenisKelamin;
    data['tanggal_lahir'] = this._tanggalLahir;
    data['bio'] = this._bio;
    data['nomor_hp'] = this._nomorHp;
    data['alamat'] = this._alamat;
    data['desa'] = this._desa;
    data['kecamatan'] = this._kecamatan;
    data['kabupaten'] = this._kabupaten;
    data['image_profile'] = this._imageProfile;
    data['is_gaduan'] = this._isGaduan;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
