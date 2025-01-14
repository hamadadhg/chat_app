import 'package:chat_app/components/text_component.dart';
import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

void showMessageToUser({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextComponent(
        text: text,
        color: kWhiteColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.lightBlue,
      duration: const Duration(
        seconds: 5,
      ),
    ),
  );
}
