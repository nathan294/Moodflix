// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:provider/provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late String email;
  late String password;
  final BuildContext context;

  LoginBloc(this.context) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    // When the user clicks on the register button
    on<SignUpButtonEvent>(_signUpUser);

    // When the user clicks on the sign-in button
    on<SignInButtonEvent>(_signInUser);

    // When Firebase has returned user credentials
    on<CredentialsRetrievedEvent>(_loginWithCredential);
  }

  FutureOr<void> _signUpUser(
      SignUpButtonEvent event, Emitter<LoginState> emit) async {
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
          error: e.toString(), message: "Une erreur est survenue."));
      context.read<Logger>().e("Une erreur inconnue est survenue",
          error: e.toString(), stackTrace: s);
    }
  }

  FutureOr<void> _signInUser(
      SignInButtonEvent event, Emitter<LoginState> emit) async {
    email = event.email;
    password = event.password;
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      add(CredentialsRetrievedEvent(credential: credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(
            error: e.toString(),
            message: "Aucun utilisateur trouvé pour cet email."));
        context.read<Logger>().i('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(
            error: e.toString(), message: "Mot de passe incorrect."));
        context.read<Logger>().i('Wrong password provided for that user.');
      }
    }
  }

  _loginWithCredential(
      CredentialsRetrievedEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoadingState());

      // If firebase login succeeds (User is retrieved)
      if (event.credential.user != null) {
        context.read<Logger>().i("Firebase login succeeded");

        // Create the user in our database
        Response response = await _createUser(event.credential.user!);

        // If the user is already created
        if (response.statusCode == 400) {
          context.read<Logger>().i("User already created in database");
          emit(UserAlreadyCreatedState());

          // If the user is a new user (and created successfully)
        } else if (response.statusCode == 200) {
          context.read<Logger>().i("User created successfully in database");
          emit(UserCreatedState());

          // If status code has an error
        } else {
          context.read<Logger>().e(
              "Une erreur inconnue est survenue, status code ${response.statusCode}");
        }
      } else {
        emit(LoginErrorState(
            error: "Erreur pendant la connexion firebase  (user null)",
            message: "Erreur pendant la connexion firebase"));
        context
            .read<Logger>()
            .e("Erreur pendant la connexion firebase  (user null)");
      }
    } catch (e, s) {
      emit(LoginErrorState(
          error: e.toString(), message: "Une erreur est survenue."));
      context.read<Logger>().e("Une erreur inconnue est survenue",
          error: e.toString(), stackTrace: s);
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
