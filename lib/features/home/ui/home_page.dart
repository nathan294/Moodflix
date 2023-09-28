import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/search_page");
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const Center(child: Text("Home")),
    );
  }
}
