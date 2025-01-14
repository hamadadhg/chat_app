import 'dart:io';
import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> sendAudioMessage(
    String audioFilePath, BuildContext context) async {
  File audioFile = File(
    audioFilePath,
  ); //convert path audioMessage(String) to File(to enable upload audioMessage on FireStorage)

  // Upload to Firebase Storage
  FirebaseStorage storage = FirebaseStorage.instance; //initialize FireStorage
  String fileName =
      'audios/audio_${DateTime.now().millisecondsSinceEpoch}.aac'; //unique name for fileAudioMessage
  Reference ref = storage.ref().child(
      fileName); //specific reference like i want to create specific name for this place in FirebaseStorage
  UploadTask uploadTask = ref.putFile(
      audioFile); //i want to putFile(upload(audioFile)) in specific place in FirebaseStorage(ref)

  try {
    final TaskSnapshot snapshot =
        await uploadTask; //wait to upload voiceMessage in FirebaseStorage and assign voiceMessage to parameter
    String downloadUrl = await snapshot.ref
        .getDownloadURL(); //now i can say this voiceMessage in specific refernce i want to dowload, so your voiceMessage there is in your ChatView and in FirebaseStorage
    //save the downloadURL in FirebaseFirestore(FirebaseFirestore can save files done upload it so you should download file from FirebaseStorage to save it in FirebaseFirestore)
    await FirebaseFirestore.instance.collection(kMessagesCollection).add(
      {
        kAudioField: downloadUrl, //add audio URL
        kTimeStampField: DateTime.now(),
        kAccountField: BlocProvider.of<AuthCubit>(context).email,
      },
    );
  } catch (e) {
    throw Exception(
      'Error Sending Audio Message: ${e.toString()}',
    );
  }
}
