import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';

void showAddMovieListDialog(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Créer une liste"),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: "Titre"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Retour"),
          ),
          TextButton(
            onPressed: () {
              final String title = titleController.text;
              if (title.isNotEmpty) {
                // Trigger the add MovieList event here
                BlocProvider.of<CollectionBloc>(context).add(
                  AddMovieListEvent(title: title),
                );
              }
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Ajouter"),
          ),
        ],
      );
    },
  );
}
