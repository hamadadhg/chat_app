import 'package:chat_app/categories/log_in_and_register_category.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});
  static String logInId = 'LogInPage';
  @override
  Widget build(BuildContext context) {
    return LogInAndRegisterCategory(
      firstText: kLogIn,
      secondText: kLogIn,
      thirdText: 'don\'t have an account ?  ',
      fourthText: '  Sign Up',
      press: () {
        Navigator.of(context).pushNamed(
          RegisterPage.registerId,
        );
      },
    );
  }
}
