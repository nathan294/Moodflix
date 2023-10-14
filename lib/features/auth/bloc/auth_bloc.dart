// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/enum/auth_status.dart';
import 'package:moodflix/core/injection.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late String email;
  late String password;
  final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();
  final Dio dio = getIt<Dio>();
  final Logger logger = getIt<Logger>();
  final AppConfig config = getIt<AppConfig>();

  AuthBloc() : super(AuthInitial()) {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        add(AppStarted());
      }
    });
    on<AppStarted>(_onAppStart);

    // When the user clicks on the register button
    on<SignUpButtonEvent>(_signUpUser);

    // When the user clicks on the sign-in button
    on<SignInButtonEvent>(_signInUser);

    // When Firebase has returned user credentials
    on<CredentialsRetrievedEvent>(_loginWithCredential);
  }

  FutureOr<void> _onAppStart(AppStarted event, Emitter<AuthState> emit) {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthSuccessedState(status: AuthStatus.returningUser));
    }
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
        logger.e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(LoginErrorState(
            error: e.toString(),
            message: "Un compte existe déjà avec cette adresse email."));
        logger.e('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        emit(LoginErrorState(
            error: e.toString(), message: "Format d'adresse email invalide."));
        logger.e('The account already exists for that email.');
      } else {
        emit(LoginErrorState(error: e.toString(), message: e.code));
        logger.e('${e.code} - ${e.toString()}');
      }
    } catch (e, s) {
      emit(LoginErrorState(
          error: e.toString(), message: "Une erreur inconnue est survenue."));
      logger.e("Une erreur inconnue est survenue",
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
        logger.e('Identifiants invalides');
      } else {
        emit(LoginErrorState(error: e.toString(), message: e.toString()));
        logger.e(e.toString(), error: e);
      }
    }
  }

  _loginWithCredential(
      CredentialsRetrievedEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoginLoadingState());

      if (event.credential.user != null) {
        logger.i("Firebase login succeeded");

        Response response = await _createUser(event.credential.user!);

        if (response.statusCode == 200) {
          logger.i("User created successfully in database");
          emit(AuthSuccessedState(status: AuthStatus.newUser));
        } else {
          logger.e(
              "An unknown error occurred, status code ${response.statusCode}");
        }
      } else {
        emit(LoginErrorState(
            error: "Error during Firebase login (user null)",
            message: "Error during Firebase login"));
        logger.e("Error during Firebase login (user null)");
      }
    } catch (e, s) {
      if (e is DioException) {
        // Check for a 409 status code specifically
        if (e.response?.statusCode == 409) {
          logger.i("User already created in database");
          emit(AuthSuccessedState(status: AuthStatus.returningUser));
        }
      } else {
        emit(LoginErrorState(
            error: e.toString(), message: "An error occurred."));
        logger.e("An unknown error occurred",
            error: e.toString(), stackTrace: s);
      }
    }
  }

  Future<Response> _createUser(User user) async {
    // Prepare url, headers and body of the request
    final String apiUrl = '${config.apiBaseUrl}/user/';
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
