/*
import 'package:chat_app/models/messages_model.dart';
import 'package:flutter/material.dart';

class ContainerBubbleCategory extends StatelessWidget {
  const ContainerBubbleCategory({
    super.key,
    required this.alignDirection,
    required this.colorContainer,
    required this.bottomRight,
    required this.bottomLeft,
    required this.colorText,
    required this.recieveMessage,
  });
  final MessagesModel recieveMessage;
  final AlignmentGeometry alignDirection;
  final Color colorContainer;
  final double bottomRight;
  final double bottomLeft;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignDirection,
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 7,
        ),
        decoration: BoxDecoration(
          color: colorContainer,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(
              27,
            ),
            topRight: const Radius.circular(
              27,
            ),
            bottomRight: Radius.circular(
              bottomRight,
            ),
            bottomLeft: Radius.circular(
              bottomLeft,
            ),
          ),
        ),
        child: Text(
          recieveMessage.message,
          style: TextStyle(
            color: colorText,
          ),
        ),
      ),
    );
  }
}
*/
