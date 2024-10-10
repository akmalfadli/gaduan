import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/network_utils/post_controller.dart';
import 'package:gaduan/widget/circle_avatar.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.user});
  final User user;
  @override
  State<PostScreen> createState() => _PostScreenState(user);
}

class _PostScreenState extends State<PostScreen> {
  String name = '';
  var description;
  var _image;
  var imagePicker;
  var isloading = false;
  final User user;
  final textController = TextEditingController();

  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  PostController postController = Get.put(PostController());
  AuthController auth = Get.find<AuthController>();

  _PostScreenState(this.user);

  @override
  void initState() {
    imagePicker = ImagePicker();
    super.initState();
  }

  _getFromGallery() async {
    XFile image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image.path);
    });
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _cropImage();
      });
    }
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat postingan'),
        actions: [
          InkWell(
              onTap: () async {
                description = textController.text;
                if (_image != null) {
                  postController.upload(_image, description);
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Center(child: Text('POSTING')),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => circleAvatar(
                          imageFromUrl: auth.user.value.imageProfile)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Apa yang anda pikirkan ?',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              user.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async =>
                        await _getFromGallery(), //_getFromGallery,
                    icon: const Icon(
                      FontAwesomeIcons.image,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: TextFormField(
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'postingan tidak boleh kosong';
                    }
                  },
                  controller: textController,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      child: _image != null
                          ? Image.file(
                              _image,
                              width: 250.0,
                              height: 250.0,
                              fit: BoxFit.fitHeight,
                            )
                          : Container()),
                  Obx(() {
                    return postController.isDataLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : Container();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
