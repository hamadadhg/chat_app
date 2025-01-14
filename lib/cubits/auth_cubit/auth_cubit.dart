import 'package:chat_app/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(
          AuthInitialState(),
        );
  String? email, password;
  Future<void> registerUserMethod() async {
    emit(
      AuthLoadingState(),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(
        AuthSuccessState(
          successMessage: 'The Log Is Success',
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          AuthFailureState(
            errorMessage: 'The Password Is Weak Or UnCompleted',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          AuthFailureState(
            errorMessage: 'The Email Already Is Exists',
          ),
        );
      }
    } catch (e) {
      emit(
        AuthFailureState(
          errorMessage: 'catch an error ${e.toString()}',
        ),
      );
    }
  }

  Future<void> loginUserMethod() async {
    emit(
      AuthLoadingState(),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(
        AuthSuccessState(
          successMessage: 'The Log Is Success',
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          AuthFailureState(
            errorMessage: 'The Email Isn\'t Found',
          ),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          AuthFailureState(
            errorMessage: 'The Password Is Wrong',
          ),
        );
      }
    } catch (e) {
      emit(
        AuthFailureState(
          errorMessage: 'catch an error ${e.toString()}',
        ),
      );
    }
  }
}
