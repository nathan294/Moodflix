import 'package:flutter/material.dart';

class RateButton extends StatelessWidget {
  const RateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.star_outline_rounded),
        label: const Text("Noter"));
  }
}
