import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/login/bloc/login_bloc.dart';
import 'package:moodflix/features/login/ui/login_page.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginBloc(context), child: const LoginPage());
  }
}
