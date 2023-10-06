import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Bienvenue sur Moodflix !"),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Se connecter")),
              ElevatedButton(onPressed: () {}, child: const Text("S'inscrire")),
            ],
          ),
        ],
      ),
    );
  }
}
