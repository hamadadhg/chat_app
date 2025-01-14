abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  String successMessage;
  AuthSuccessState({
    required this.successMessage,
  });
}

class AuthFailureState extends AuthState {
  String errorMessage;
  AuthFailureState({
    required this.errorMessage,
  });
}
