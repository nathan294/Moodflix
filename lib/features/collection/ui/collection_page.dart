import 'package:flutter/material.dart';
import 'package:moodflix/features/collection/ui/collection_body.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Collection")),
      body: CollectionBody(),
    );
  }
}
