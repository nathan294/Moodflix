import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:moodflix/config/app_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page de test !"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Appli de : ${AppConfig.of(context)!.flavorName}',
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(
              height: 20,
            ),
            Text(AppLocalizations.of(context)!.itemDetail),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  // context.push("/login");
                },
                child: const Text('Page de login')),
            ElevatedButton(
                onPressed: () {
                  // context.push("/onboarding");
                },
                child: const Text("Page onboarding")),
            ElevatedButton(
                onPressed: () {
                  context.push("/test_animation");
                },
                child: const Text('Test animation')),
          ],
        ),
      ),
    );
  }
}
