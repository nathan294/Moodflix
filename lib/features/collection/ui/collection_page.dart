import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Collection")),
      body: const Center(
          child: Text("Bientôt ici les notes et la liste d'envies")),
    );
  }
}
