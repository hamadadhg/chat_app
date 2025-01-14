/*
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadAudioToStorage(File audioFile) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  String fileName = 'audio_${DateTime.now().millisecondsSinceEpoch}.aac';
  TaskSnapshot uploadTask = await storage
      .ref(
        'audio_message/$fileName',
      )
      .putFile(
        audioFile,
      );
  String downloadUrl = await uploadTask.ref.getDownloadURL();
  return downloadUrl;
}
*/
