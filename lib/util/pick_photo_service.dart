import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter_app/app/networking/api_service.dart';

class UploadPhotoService {
  File? photo = null;

  BuildContext context;

  late NavigatorState _navigator;


  UploadPhotoService(this.context) {
    _navigator = Navigator.of(context);
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (result.count == 1 &&
          ["png", "jpg", "jpeg"].contains(result.names[0]!.split(".").last)) {
        photo = File(result.files.single.path!);

        return;
      }
      //   _closeDialog("pick_photo.not_mp3".tr());
      //   return;
      // } else {
      //   _closeDialog("pick_photo.not_chosen".tr());
    }
  }

  Future<void> _uploadFile() async {
    if (photo != null) {
      await ApiService().putUserPhoto(photo!);
      _navigator.pop();
    }
  }

  Future<void> showUploadDialog() async {
    await _pickFile();
    if (photo != null) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("pick_photo.upload".tr()),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(photo!.path.split("/").last),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: _navigator.pop,
                child: Text("general.cancel".tr()),
              ),
              TextButton(
                onPressed: _uploadFile,
                child: Text("general.ok".tr()),
              ),
            ],
          );
        },
      );
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("pick_photo.upload".tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("pick_photo.not_chosen".tr()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: _navigator.pop,
              child: Text("general.cancel".tr()),
            ),
          ],
        );
      },
    );
  }
}
