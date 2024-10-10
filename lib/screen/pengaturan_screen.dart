// home_material.dart
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/pengaturan_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PengaturanScreen extends StatefulWidget {
  PengaturanScreen({required this.user});
  final User user;

  @override
  _PengaturanScreenState createState() => _PengaturanScreenState(user);
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  final _formKey = GlobalKey<FormState>();
  var _image;
  var imagePicker;
  String tanggalLahir = '';
  final User user;
  int jenisKelamin = 0;
  late TextEditingController dateCtl;

  _PengaturanScreenState(this.user);

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    dateCtl = TextEditingController();
    dateCtl.text = user.tanggalLahir ?? '';
  }

  _getFromGallery() async {
    XFile image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    _image = File(image.path);
  }

  final PengaturanController _controller = Get.put(PengaturanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
        ),
        actions: [
          GestureDetector(
            onTap: () {
              final form = _formKey.currentState;
              if (form!.validate()) {
                form.save();

                print('user save: ${user.toJson()}');
                _controller.updateUser(data: user.toJson(), image: _image);
              }
            },
            child: Center(
              child: const Text(
                'SIMPAN     ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        Obx(() => _controller.isDataLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container()),
        Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: user.imageProfile != null &&
                                      user.imageProfile != ''
                                  ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: '$imageUrl${user.imageProfile}',
                                      imageBuilder: ((context, imageProvider) =>
                                          CircleAvatar(
                                              child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fitWidth),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(80))),
                                          ))),
                                    )
                                  : const CircleAvatar(
                                      backgroundImage: ExactAssetImage(
                                          'assets/images/male_profile_placeholder.jpg'),
                                    ),
                            ),
                            TextButton(
                                onPressed: () => _getFromGallery(),
                                child: const Text('Edit Profile')),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    initialValue: user.name,
                                    decoration: const InputDecoration(
                                        labelText: 'Nama'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Silahkan masukan nama lengkap ';
                                      }
                                    },
                                    onSaved: (val) => {user.name = val},
                                  ),
                                ),
                                SizedBox(width: 16),
                                DropdownButton(
                                  isDense: true,
                                  hint: user.jenisKelamin != null
                                      ? Text(
                                          user.jenisKelamin == 1
                                              ? 'Laki-laki'
                                              : 'Perempuan',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      : Text('Pilih jenis kelamin'),
                                  items: ['Laki-laki', 'Perempuan']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    if (value == 'Laki-laki') {
                                      setState(() {
                                        jenisKelamin = 1;
                                        user.jenisKelamin = 1;
                                      });
                                    } else if (value == 'Perempuan') {
                                      setState(() {
                                        jenisKelamin = 2;
                                        user.jenisKelamin = 2;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: user.email,
                              decoration: const InputDecoration(
                                  labelText: 'Alamat Email'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan masukan alamat email anda ';
                                }
                              },
                              onSaved: (val) => {user.email = val},
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                                initialValue: user.nomorHp ?? '',
                                decoration: const InputDecoration(
                                    labelText: 'Nomor Hp'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Silahkan masukan nomor handphone';
                                  }
                                },
                                onSaved: (val) {
                                  user.nomorHp = val;
                                }),
                            const SizedBox(height: 8),
                            TextFormField(
                                controller: dateCtl,
                                decoration: const InputDecoration(
                                  labelText: 'Tanggal Lahir',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Silahkan masukan tanggal lahir';
                                  }
                                },
                                onTap: () async {
                                  DateTime? date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  setState(() {
                                    dateCtl.text =
                                        date.toString().split(' ')[0];
                                  });
                                },
                                onSaved: (val) {
                                  user.tanggalLahir = dateCtl.text;
                                }),
                            const SizedBox(height: 32),
                            TextFormField(
                              initialValue: user.bio ?? '',
                              minLines: 2,
                              maxLines: 5,
                              decoration:
                                  const InputDecoration(labelText: 'Bio'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan masukan bio anda ';
                                }
                              },
                              onSaved: (val) => {user.bio = val},
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                                initialValue: user.alamat ?? '',
                                decoration:
                                    const InputDecoration(labelText: 'Alamat'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Silahkan masukan alamat';
                                  }
                                },
                                onSaved: (val) {
                                  user.alamat = val;
                                }),
                            const SizedBox(height: 8),
                            TextFormField(
                              initialValue: user.desa ?? '',
                              decoration:
                                  const InputDecoration(labelText: 'Desa'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan masukan desa';
                                }
                              },
                              onSaved: (val) => {user.desa = val},
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                                initialValue: user.kecamatan ?? '',
                                decoration: const InputDecoration(
                                    labelText: 'Kecamatan'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Silahkan masukan kecamatan';
                                  }
                                },
                                onSaved: (val) {
                                  user.kecamatan = val;
                                }),
                            const SizedBox(height: 8),
                            TextFormField(
                                initialValue: user.kabupaten ?? '',
                                decoration: const InputDecoration(
                                    labelText: 'Kabupaten'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Silahkan masukan kabupaten';
                                  }
                                },
                                onSaved: (val) {
                                  user.kabupaten = val;
                                }),
                          ]),
                    )))),
      ]),
    );
  }
}
