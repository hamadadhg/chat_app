/*
import 'package:chat_app/helper/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestMicrophonePermission(BuildContext context) async {
  var status = await Permission.microphone.status;
  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    await Permission.microphone.request();
    return await Permission.microphone.isGranted;
  }
  if (status.isPermanentlyDenied) {
    showMessageToUser(
      context: context,
      text:
          'Permission is permanently denied. Please enable it from app settings.',
    );
    openAppSettings();
    return false;
  }
  return false;
}
*/
