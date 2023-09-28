import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movie_search/bloc/bloc.dart';
import 'package:moodflix/features/movie_search/widgets/movies_list.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late FocusNode myFocusNode;
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieSearchBloc, MovieSearchState>(
      listener: (context, state) {
        // Your existing listener logic
      },
      child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: myController,
                focusNode: myFocusNode,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        myController.clear();
                        context.read<MovieSearchBloc>().add(TextWipeEvent());
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
                onChanged: (value) => context
                    .read<MovieSearchBloc>()
                    .add(TextChangeEvent(text: myController.text)),
              ),
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }
}

Widget _buildBody(MovieSearchState state) {
  if (state is MoviesLoadingState) {
    return const Center(child: CircularProgressIndicator());
  }
  if (state is MoviesLoadedState) {
    return MoviesList(movies: state.movies);
  }
  if (state is MovieSearchInitialState) {
    return Container();
  } else {
    return const Center(child: Text("Une erreur est survenue"));
  }
}
