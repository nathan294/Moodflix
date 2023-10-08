import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodflix/features/home/ui/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/search_page");
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const HomeBody(),
    );
  }
}
