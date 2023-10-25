import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/collection/bloc/collection_bloc.dart';
import 'package:moodflix/features/movie_details/blocs/rating_cubit/rating_cubit.dart';
import 'package:moodflix/features/movie_details/blocs/wishlist_cubit/wishlist_cubit.dart';

class RateButton extends StatefulWidget {
  final int? selectedRating;

  const RateButton({Key? key, this.selectedRating}) : super(key: key);

  @override
  RateButtonState createState() => RateButtonState();
}

class RateButtonState extends State<RateButton> {
  int? selectedRating;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.selectedRating;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatingCubit, RatingState>(
      listener: (context, state) {
        if (state is MovieRated) {
          // Unwish the movie if it has been added to wishlist
          final WishlistState wishlistState =
              BlocProvider.of<WishlistCubit>(context).state;
          if (wishlistState is WishlistAdded) {
            BlocProvider.of<WishlistCubit>(context).toggleWishlist();
          }

          // Reload CollectionBloc data
          BlocProvider.of<CollectionBloc>(context).add(LoadInitialData());
        }
        if (state is MovieNotRated) {
          // Reload CollectionBloc data
          BlocProvider.of<CollectionBloc>(context).add(LoadInitialData());
        }
      },
      child: BlocBuilder<RatingCubit, RatingState>(
        builder: (context, state) {
          if (state is MovieNotRated) {
            // When movie is not rated
            return ElevatedButton.icon(
              onPressed: () {
                _showModal(context, null);
              },
              icon: const Icon(Icons.star_outline_rounded),
              label: const Text("Noter"),
            );
          } else if (state is MovieRated) {
            // When movie is already rated
            return FilledButton.icon(
              onPressed: () {
                _showModal(context, state.rating);
              },
              icon: const Icon(Icons.check),
              label: const Text("Noté"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  _showModal(BuildContext context, int? initialRating) {
    int? selectedRating = initialRating;
    bool clearClicked = false; // New state variable to track if the "clear"
    const double itemWidth = 88.0; // width of each item including its margin
    final ScrollController scrollController = ScrollController(
      initialScrollOffset:
          selectedRating != null ? (selectedRating - 3) * itemWidth : 0.0,
    );

    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Choisissez une note',
                      style: TextStyle(fontSize: 21),
                    ),
                    SizedBox(
                      height: 100,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.clear,
                                  color: clearClicked
                                      ? Colors.red
                                      : null), // Conditionally set the color,
                              onPressed: () {
                                setState(() {
                                  selectedRating = 0;
                                  clearClicked =
                                      true; // Set to true when clicked
                                });
                              },
                            ),
                            ...List.generate(10, (index) => index + 1).map(
                              (e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedRating = e;
                                    clearClicked =
                                        false; // Set to false when clicked
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    color: selectedRating == e
                                        ? _fillColor(selectedRating)
                                        : Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$e',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    clearClicked // Conditionally change the button based on the state
                        ? FilledButton(
                            child: const Text('Supprimer la note'),
                            onPressed: () {
                              Navigator.pop(context, selectedRating);
                            },
                          )
                        : ElevatedButton(
                            child: const Text('Valider'),
                            onPressed: () {
                              Navigator.pop(context, selectedRating);
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((newSelectedRating) {
      if (newSelectedRating != null && newSelectedRating != 0) {
        BlocProvider.of<RatingCubit>(context).rateMovie(newSelectedRating);
        setState(() {
          selectedRating = newSelectedRating;
        });
      } else if (newSelectedRating == 0 && initialRating != null) {
        BlocProvider.of<RatingCubit>(context).unrateMovie(initialRating);
      }
    });
  }

  Color _fillColor(int? selectedRating) {
    if (selectedRating == null) {
      return Colors.grey;
    } else {
      if (selectedRating > 7) {
        return Colors.green;
      } else if (selectedRating >= 5) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }
  }
}
