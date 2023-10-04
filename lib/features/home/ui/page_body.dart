import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/home/bloc/home_bloc.dart';
import 'package:moodflix/features/home/widgets/movies_carousel.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is DataLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is DataLoadedState) {
          return SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              children: [
                const Center(child: Text("Films populaires")),
                MoviesCarousel(movies: state.popularMovies),
                const SizedBox(
                  height: 5,
                ),
                const Center(child: Text("À l'affiche")),
                MoviesCarousel(movies: state.nowPlayingMovies),
                const SizedBox(
                  height: 5,
                ),
                const Center(child: Text("Prochaines sorties")),
                MoviesCarousel(movies: state.upcomingMovies),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
