import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/collection/ui/collection_body.dart';
import 'package:moodflix/features/collection/widgets/add_movie_list_dialog.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Collection")),
      body: const CollectionBody(),
      floatingActionButton: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          if (state is DataLoadedState) {
            return FloatingActionButton(
              onPressed: () {
                showAddMovieListDialog(context);
              },
              child: const Icon(Icons.add),
            );
          }
          return Container(); // return an empty container if not in DataLoadedState
        },
      ),
    );
  }
}
