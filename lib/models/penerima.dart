class PenerimaModel {
  bool? _success;
  List<DataPenerima>? _data;

  PenerimaModel({bool? success, List<DataPenerima>? data}) {
    if (success != null) {
      this._success = success;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  List<DataPenerima>? get data => _data;
  set data(List<DataPenerima>? data) => _data = data;

  PenerimaModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = <DataPenerima>[];
      json['data'].forEach((v) {
        _data!.add(new DataPenerima.fromJson(v));
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

class DataPenerima {
  int? _id;
  String? _nik;
  Null? _noKk;
  String? _nama;
  int? _jenisKelamin;
  int? _rt;
  int? _rw;
  Null? _nomorHp;
  Null? _userId;
  Null? _createdAt;
  Null? _updatedAt;

  DataPenerima(
      {int? id,
      String? nik,
      Null? noKk,
      String? nama,
      int? jenisKelamin,
      int? rt,
      int? rw,
      Null? nomorHp,
      Null? userId,
      Null? createdAt,
      Null? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (nik != null) {
      this._nik = nik;
    }
    if (noKk != null) {
      this._noKk = noKk;
    }
    if (nama != null) {
      this._nama = nama;
    }
    if (jenisKelamin != null) {
      this._jenisKelamin = jenisKelamin;
    }
    if (rt != null) {
      this._rt = rt;
    }
    if (rw != null) {
      this._rw = rw;
    }
    if (nomorHp != null) {
      this._nomorHp = nomorHp;
    }
    if (userId != null) {
      this._userId = userId;
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
  String? get nik => _nik;
  set nik(String? nik) => _nik = nik;
  Null? get noKk => _noKk;
  set noKk(Null? noKk) => _noKk = noKk;
  String? get nama => _nama;
  set nama(String? nama) => _nama = nama;
  int? get jenisKelamin => _jenisKelamin;
  set jenisKelamin(int? jenisKelamin) => _jenisKelamin = jenisKelamin;
  int? get rt => _rt;
  set rt(int? rt) => _rt = rt;
  int? get rw => _rw;
  set rw(int? rw) => _rw = rw;
  Null? get nomorHp => _nomorHp;
  set nomorHp(Null? nomorHp) => _nomorHp = nomorHp;
  Null? get userId => _userId;
  set userId(Null? userId) => _userId = userId;
  Null? get createdAt => _createdAt;
  set createdAt(Null? createdAt) => _createdAt = createdAt;
  Null? get updatedAt => _updatedAt;
  set updatedAt(Null? updatedAt) => _updatedAt = updatedAt;

  DataPenerima.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nik = json['nik'];
    _noKk = json['no_kk'];
    _nama = json['nama'];
    _jenisKelamin = json['jenis_kelamin'];
    _rt = json['rt'];
    _rw = json['rw'];
    _nomorHp = json['nomor_hp'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nik'] = this._nik;
    data['no_kk'] = this._noKk;
    data['nama'] = this._nama;
    data['jenis_kelamin'] = this._jenisKelamin;
    data['rt'] = this._rt;
    data['rw'] = this._rw;
    data['nomor_hp'] = this._nomorHp;
    data['user_id'] = this._userId;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
