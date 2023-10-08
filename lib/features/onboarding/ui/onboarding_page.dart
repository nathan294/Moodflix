import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
              onPressed: () {
                context.go('/home');
              },
              icon: const Icon(
                Icons.keyboard_double_arrow_right,
                size: 24.0,
              ),
              label: const Text('Skip'),
            ),
          ),
        ],
      ),
      body: const Center(child: Text("Onboarding page")),
    );
  }
}
