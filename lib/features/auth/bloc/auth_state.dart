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

// This state indicates that auth has succeeded.
final class AuthSuccessedState extends AuthState {
  final AuthStatus status;

  AuthSuccessedState({required this.status});
}
