part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

// When the user clicks on the submit button on the sign-up form
class SignUpButtonEvent extends LoginEvent {
  final String email;
  final String password;

  SignUpButtonEvent({required this.email, required this.password});

  List<Object> get props => [email, password];
}

// When the user clicks the button to sign-in
class SignInButtonEvent extends LoginEvent {
  final String email;
  final String password;

  SignInButtonEvent({required this.email, required this.password});

  List<Object> get props => [email, password];
}

// When the user has been registered/signed-in successfully from Firebase
class CredentialsRetrievedEvent extends LoginEvent {
  final UserCredential credential;
  CredentialsRetrievedEvent({
    required this.credential,
  });
}
