import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Bienvenue sur Moodflix !"),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context.pushNamed("signin");
                      },
                      child: const Text("Se connecter")),
                  ElevatedButton(
                      onPressed: () {
                        context.pushNamed("signup");
                      },
                      child: const Text("S'inscrire")),
                ],
              ),
            ],
          ),
        ));
  }
}
