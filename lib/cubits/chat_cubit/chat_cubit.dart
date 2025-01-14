import 'dart:io';
import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app/helper/snack_bar_helper.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snappable_thanos/snappable_thanos.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          InitialChatState(),
        );

  CollectionReference message = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  List<MessagesModel> getMessages = [];

  void sendMessage(
      {required ScrollController scrollController,
      required TextEditingController textController,
      required BuildContext context,
      required String theAccount}) {
    try {
      if (textController.text.isNotEmpty) {
        var localTimestamp = DateTime.now();
        FirebaseFirestore.instance
            .collection(
          kMessagesCollection,
        )
            .add(
          {
            kMessageField: textController.text,
            kTimeStampField: localTimestamp,
            kAccountField: theAccount,
          },
        ).then(
          (_) {
            textController.clear();
            scrollController.animateTo(
              0,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeIn,
            );
          },
        ).catchError(
          (
            error,
          ) {
            showMessageToUser(
              context: context,
              text: error.toString(),
            );
          },
        );
      }
    } on Exception catch (e) {
      showMessageToUser(
        context: context,
        text: 'catch an error ${e.toString()}',
      );
    }
  }

  void getMessage() {
    message
        .orderBy(
          kTimeStampField,
          descending: true,
        )
        .snapshots()
        .listen(
      (snapShot) {
        getMessages = snapShot.docs
            .map(
              (doc) => MessagesModel.fromJson(
                doc,
              ),
            )
            .toList();
        emit(
          SuccessChatState(),
        );
      },
    );
  }

  Future<void> sendAndGetAudioMessage(
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
      emit(
        SuccessChatState(),
      );
    } catch (e) {
      throw Exception(
        'Error Sending Audio Message: ${e.toString()}',
      );
    }
  }

  void deleteMessageAndVoiceMessage(
      {required Set<String> selectedMessageIds,
      required Map<String, GlobalKey<SnappableState>> snappableKeys,
      required BuildContext context}) {
    for (String messageId in selectedMessageIds) {
      final snappableState = snappableKeys[messageId]
          ?.currentState; //currentState reference to connect state with GlobalKey
      //trigger the snap effect for the selected message if there is snappableState and sanppableState dosen't go for now(doesn't delete)
      if (snappableState != null && !snappableState.isGone) {
        snappableState.snap();
      } else {
        snappableState?.reset();
      }
    }
    // Delay the deletion from Firestore to allow snap animation to complete
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
      () {
        for (String messageId in selectedMessageIds) {
          FirebaseFirestore.instance
              .collection(
                kMessagesCollection,
              )
              .doc(
                messageId,
              )
              .delete()
              .catchError(
            (
              error,
            ) {
              showMessageToUser(
                context: context,
                text: 'Error deleting message: $error',
              );
            },
          );
        }
        emit(
          DeleteChatState(),
        );
        //clear the selectedMessagesIds after deletion
        selectedMessageIds.clear();
      },
    );
  }
}
