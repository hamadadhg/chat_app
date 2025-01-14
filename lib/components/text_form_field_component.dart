/*
import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatefulWidget {
  const TextFormFieldComponent({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.onChanged,
    required this.validation,
  });
  final String hintText;
  final TextInputType textInputType;
  final Function(String) onChanged;
 final String? Function(String?) validation;

  @override
  State<TextFormFieldComponent> createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      onChanged: widget.onChanged,
      obscureText: isObscureText,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontSize: 15,
          color: kRedColor,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kWhiteColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPinkColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kRedColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kRedColor,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kWhiteColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscureText ? Icons.visibility_off : Icons.visibility,
            color: kWhiteColor,
          ),
          onPressed: () {
            setState(
              () {
                isObscureText = !isObscureText;
              },
            );
          },
        ),
      ),
      style: TextStyle(
        color: kWhiteColor,
      ),
      keyboardType: widget.textInputType,
    );
  }
}
*/
