import 'package:flutter/material.dart';
import 'package:moodflix/features/login/ui/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")), body: const LoginBody());
  }
}
