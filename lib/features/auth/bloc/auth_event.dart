part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// When App starts
class AppStarted extends AuthEvent {}

// When the user clicks on the submit button on the sign-up form
class SignUpButtonEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpButtonEvent({required this.email, required this.password});

  List<Object> get props => [email, password];
}

// When the user clicks the button to sign-in
class SignInButtonEvent extends AuthEvent {
  final String email;
  final String password;

  SignInButtonEvent({required this.email, required this.password});

  List<Object> get props => [email, password];
}

// When the user has been registered/signed-in successfully from Firebase
class CredentialsRetrievedEvent extends AuthEvent {
  final UserCredential credential;
  CredentialsRetrievedEvent({
    required this.credential,
  });
}
