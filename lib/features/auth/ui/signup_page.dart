import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:moodflix/core/enum/auth_status.dart';
import 'package:moodflix/core/injection.dart';
import 'package:moodflix/features/auth/bloc/auth_bloc.dart';
import 'package:moodflix/features/auth/validators/validators.dart';
import 'package:moodflix/features/auth/widgets/email_field.dart';
import 'package:moodflix/features/auth/widgets/password_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  String? email, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Auth Succeeded.
        // Redirecting user to either onboarding or home, depending where he is a new user or not
        if (state is AuthSuccessedState) {
          if (state.status == AuthStatus.newUser) {
            context.goNamed('onboarding');
          } else {
            context.go('/home');
          }
        }

        //Show error message if any error occurs while verifying phone number and otp code
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sign Up'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyEmailFormField(
                      label: 'Email',
                      validator: validateEmail,
                      onSaved: (value) => email = value,
                    ),
                    MyPasswordFormField(
                        label: 'Password',
                        controller: _passwordController,
                        validator: validatePassword,
                        onSaved: (value) {
                          password = value;
                        }),
                    MyPasswordFormField(
                      label: 'Confirm Password',
                      validator: (value) => validateConfirmPassword(
                          value, _passwordController.text),
                      onSaved: (value) => confirmPassword = value,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is LoginLoadingState)
                      const CircularProgressIndicator()
                    else
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            getIt<Logger>()
                                .i("Email: $email, Password: $password");

                            // Trigger the bloc sign up event
                            context.read<AuthBloc>().add(SignUpButtonEvent(
                                email: email!, password: password!));
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
