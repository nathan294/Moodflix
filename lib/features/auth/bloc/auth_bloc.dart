// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late String email;
  late String password;
  final BuildContext context;

  AuthBloc(this.context) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    // When the user clicks on the register button
    on<SignUpButtonEvent>(_signUpUser);

    // When the user clicks on the sign-in button
    on<SignInButtonEvent>(_signInUser);

    // When Firebase has returned user credentials
    on<CredentialsRetrievedEvent>(_loginWithCredential);
  }

  FutureOr<void> _signUpUser(
      SignUpButtonEvent event, Emitter<AuthState> emit) async {
    email = event.email;
    password = event.password;
    emit(LoginLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      add(CredentialsRetrievedEvent(credential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(LoginErrorState(
            error: e.toString(),
            message: "Le mot de passe entré n'est pas assez sécurisé."));
        context.read<Logger>().i('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(LoginErrorState(
            error: e.toString(),
            message: "Un compte existe déjà avec cette adresse email."));
        context.read<Logger>().i('The account already exists for that email.');
      }
    } catch (e, s) {
      emit(LoginErrorState(
          error: e.toString(), message: "Une erreur inconnue est survenue."));
      context.read<Logger>().e("Une erreur inconnue est survenue",
          error: e.toString(), stackTrace: s);
    }
  }

  FutureOr<void> _signInUser(
      SignInButtonEvent event, Emitter<AuthState> emit) async {
    email = event.email;
    password = event.password;
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      add(CredentialsRetrievedEvent(credential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        emit(LoginErrorState(
            error: e.toString(), message: "Identifiants invalides"));
        context.read<Logger>().e('Identifiants invalides');
      } else {
        emit(LoginErrorState(error: e.toString(), message: e.toString()));
        context.read<Logger>().e(e.toString(), error: e);
      }
    }
  }

  _loginWithCredential(
      CredentialsRetrievedEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoadingState());

      if (event.credential.user != null) {
        context.read<Logger>().i("Firebase login succeeded");

        Response response = await _createUser(event.credential.user!);

        if (response.statusCode == 200) {
          context.read<Logger>().i("User created successfully in database");
          emit(UserCreatedState());
        } else {
          context.read<Logger>().e(
              "An unknown error occurred, status code ${response.statusCode}");
        }
      } else {
        emit(LoginErrorState(
            error: "Error during Firebase login (user null)",
            message: "Error during Firebase login"));
        context.read<Logger>().e("Error during Firebase login (user null)");
      }
    } catch (e, s) {
      if (e is DioException) {
        // Check for a 409 status code specifically
        if (e.response?.statusCode == 409) {
          context.read<Logger>().i("User already created in database");
          emit(UserAlreadyCreatedState());
        }
      } else {
        emit(LoginErrorState(
            error: e.toString(), message: "An error occurred."));
        context
            .read<Logger>()
            .e("An unknown error occurred", error: e.toString(), stackTrace: s);
      }
    }
  }

  Future<Response> _createUser(User user) async {
    // Obtain the Dio instance
    final dio = context.read<Dio>();

    // Prepare url, headers and body of the request
    final String apiUrl = '${AppConfig.of(context)!.apiBaseUrl}/user/';
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final Map<String, String> body = {
      'email': email,
      'password': password,
      'firebase_id': user.uid
    };
    // Request
    return await dio.post(
      apiUrl,
      data: jsonEncode(body),
      options: Options(headers: headers),
    );
  }
}
