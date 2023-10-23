import 'package:flutter/material.dart';

class RateButton extends StatelessWidget {
  final void Function(int)
      onRate; // Callback function to receive the selected rating

  const RateButton({super.key, required this.onRate});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.onetwothree_rounded),
      label: const Text("Noter"),
      onPressed: () async {
        // Show dialog when the button is clicked
        int? selectedRating = await showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Noter ce film"),
              content: SizedBox(
                width: double.minPositive,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 11, // 0 to 10
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () {
                        Navigator.of(context).pop(index);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );

        // Handle the selected rating
        if (selectedRating != null) {
          onRate(selectedRating);
        }
      },
    );
  }
}
