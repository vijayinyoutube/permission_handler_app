import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_app/Presentation/Components/app_bar.dart';

import '../Components/primary_btn.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: title),
      body: Center(
        child: PrimaryBtn(
          btnFun: () => _getFromGallery(context),
          btnText: 'Pick Image',
        ),
      ),
    );
  }
}

/// Get from gallery
_getFromGallery(context) async {
  try {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  } catch (e) {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      print('Access Denied');
      showAlertDialog(context);
    } else {
      print('Exception occured!');
    }
  }
}

showAlertDialog(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
