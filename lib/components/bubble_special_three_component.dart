import 'package:chat_app/components/text_component.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/time_stamp_convert_to_date_time_helper.dart';
import 'package:chat_app/widget/audio_message_player_widget.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class BubbleSpecialThreeComponent extends StatelessWidget {
  const BubbleSpecialThreeComponent({
    super.key,
    required this.text,
    this.audioUrl,
    required this.color,
    required this.isSender,
    required this.recieveDateTime,
  });
  final String text;
  final String? audioUrl;
  final Color color;
  final bool isSender;
  final DateTime recieveDateTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
          ),
          child: audioUrl != null
              ? AudioMessagePlayerWidget(
                  audioUrl: audioUrl!,
                )
              : BubbleSpecialThree(
                  text: text,
                  color: color,
                  tail: true,
                  isSender: isSender,
                  textStyle: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: isSender == true
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 18,
            ),
            const SizedBox(
              height: 15,
            ),
            TextComponent(
              text: formatTimeStamp(
                recieveDateTime,
              ),
              color: kWhiteColor,
              fontSize: 12,
            ),
            const SizedBox(
              width: 18,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
