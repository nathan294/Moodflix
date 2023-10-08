part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

// This state is used to show the loading indicator.
final class AuthInitial extends AuthState {}

// This state is used to show the loading indicator (when Firebase requests for example)
final class LoginLoadingState extends AuthState {}

// This state is used to show the error message.
final class LoginErrorState extends AuthState {
  final String error;
  final String message;

  LoginErrorState({required this.error, required this.message});

  List<Object> get props => [error, message];
}

// This state indicates that Firebase verification has succeeded.
final class LoginSuccessedState extends AuthState {}

// This state indicates that user was already created in our database so he will be redirected to home screen.
final class UserAlreadyCreatedState extends AuthState {}

// This state indicates that user has been created in our database so he will be redirected to onboarding screen.
final class UserCreatedState extends AuthState {}
