import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';

class CollectionBody extends StatelessWidget {
  const CollectionBody({Key? key})
      : super(key: key); // Updated super.key to key

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
      if (state is DataLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DataLoadedState) {
        return ListView.builder(
          itemCount: state.moviesLists.length,
          itemBuilder: (context, index) {
            final movieList = state.moviesLists[index];
            return ListTile(
              title: Text(movieList.title),
              subtitle: Text(
                  "Status: ${movieList.status}, Locked: ${movieList.locked ? 'Yes' : 'No'}"),
              leading:
                  const Icon(Icons.movie), // Replace with your preferred icon
              onTap: () {
                // TODO: Navigate to the detailed view of this movie list
              },
            );
          },
        );
      } else {
        return const Center(child: Text('An unknown error occurred.'));
      }
    });
  }
}
