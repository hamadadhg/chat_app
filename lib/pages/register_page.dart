import 'package:chat_app/categories/log_in_and_register_category.dart';
import 'package:chat_app/constant.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String registerId = 'RegisterPage';
  @override
  Widget build(BuildContext context) {
    return LogInAndRegisterCategory(
      firstText: kRegister,
      secondText: kRegister,
      thirdText: 'already have an account ?  ',
      fourthText: '  Sign In',
      press: () {
        Navigator.pop(
          context,
        );
      },
    );
  }
}
