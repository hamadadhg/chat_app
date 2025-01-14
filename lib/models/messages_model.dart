import 'package:chat_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesModel {
  final String message;
  final String id;
  final String? audioUrl;
  final DateTime assignDateTime;
  final String recieveTheAccount;
  final int? audioDuration;
  MessagesModel({
    required this.id,
    required this.message,
    this.audioUrl,
    required this.assignDateTime,
    required this.recieveTheAccount,
    this.audioDuration,
  });
  factory MessagesModel.fromJson(DocumentSnapshot jsonData) {
    var data = jsonData.data() as Map<String, dynamic>;
    var timeStampData = data[kTimeStampField];
    DateTime dateTime;
    if (timeStampData is int) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timeStampData);
    } else if (timeStampData is Timestamp) {
      dateTime = timeStampData.toDate();
    } else {
      dateTime = DateTime.now();
    }
    return MessagesModel(
      id: jsonData.id,
      message: data[kMessageField] ?? '',
      audioUrl:
          data.containsKey(kAudioField) ? data[kAudioField] as String? : null,
      assignDateTime: dateTime,
      recieveTheAccount: data[kAccountField] ?? '',
      audioDuration: data['audioDuration'],
    );
  }
}
