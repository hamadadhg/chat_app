/*
import 'package:chat_app/components/text_component.dart';
import 'package:chat_app/components/text_form_field_component.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/auth_cubit/auth_state.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helper/snack_bar_helper.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInAndRegisterCategory extends StatefulWidget {
  const LogInAndRegisterCategory({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.fourthText,
    required this.press,
  });
  final String firstText;
  final String secondText;
  final String thirdText;
  final String fourthText;
  final VoidCallback press;

  @override
  State<LogInAndRegisterCategory> createState() =>
      _LogInAndRegisterCategoryState();
}

class _LogInAndRegisterCategoryState extends State<LogInAndRegisterCategory> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.of(context).pushNamed(
            ChatPage.chatId,
          );

          showMessageToUser(
            context: context,
            text: state.successMessage,
          );
        } else if (state is AuthFailureState) {
          showMessageToUser(
            context: context,
            text: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kWeakBlueColor,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          kScholarChatImage,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponent(
                            text: kScholarChatText,
                            color: kWhiteColor,
                            fontSize: 35,
                            fontFamily: 'Dancing Script',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          TextComponent(
                            text: widget.firstText,
                            color: kWhiteColor,
                            fontSize: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormFieldComponent(
                        hintText: kEmail,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (assignEmail) {
                          context.read<AuthCubit>().email = assignEmail;
                        },
                        validation: (assignValidation) {
                          if (assignValidation!.isEmpty) {
                            return 'The Field Mustn\'t Be An Empty';
                          }
                          if ((assignValidation.length < 8 ||
                                  assignValidation.length == 8 ||
                                  assignValidation.length > 8) &&
                              !assignValidation.contains('@gmail.com')) {
                            return 'Mustn\'t Be Less Of 8 , Don\'t Forget @gmail.com';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormFieldComponent(
                        hintText: kPassword,
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (assignPassword) {
                          context.read<AuthCubit>().password = assignPassword;
                        },
                        validation: (assignValidation) {
                          if (assignValidation!.isEmpty) {
                            return 'The Field Mustn\'t Be An Empty';
                          }
                          if (assignValidation.length < 8) {
                            return 'Mustn\'t Be Less Of 8 Character';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (widget.firstText == 'Register') {
                              BlocProvider.of<AuthCubit>(context)
                                  .registerUserMethod();
                            } else {
                              context.read<AuthCubit>().loginUserMethod();
                            }
                          } else {}
                        },
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Center(
                            child: TextComponent(
                              text: widget.secondText,
                              color: Colors.black,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponent(
                            text: widget.thirdText,
                            color: kWhiteColor,
                            fontSize: 16,
                          ),
                          GestureDetector(
                            onTap: widget.press,
                            child: TextComponent(
                              text: widget.fourthText,
                              color: kWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (state is AuthLoadingState)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
*/
