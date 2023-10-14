import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:moodflix/core/injection.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paramètres")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Paramètres"),
          const SizedBox(height: 20),
          if (AppConfig.of(context)!.flavorName == 'development')
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.push('/test');
                    },
                    child: const Text("Page de test")),
                const SizedBox(height: 20),
              ],
            ),
          ElevatedButton(
              onPressed: () {
                getIt<FirebaseAuth>().signOut();
                context.go('/login');
              },
              child: const Text("Se déconnecter")),
        ],
      )),
    );
  }
}
