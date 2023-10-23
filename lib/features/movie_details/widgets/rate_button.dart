import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodflix/features/movie_details/blocs/rating_cubit/rating_cubit.dart';

class RateButton extends StatelessWidget {
  const RateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingCubit, RatingState>(
      builder: (context, state) {
        return ElevatedButton.icon(
            onPressed: () {
              _showModal(context);
              // BlocProvider.of<RatingCubit>(context).rateMovie(rating);
            },
            icon: const Icon(Icons.star_outline_rounded),
            label: const Text("Noter"));
      },
    );
  }

  _showModal(BuildContext context) {
    // nullable int to indicate that no rating is initially selected
    int? selectedRating;

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
                      const Text('Votre note'),
                      SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    selectedRating = null;
                                  });
                                },
                              ),
                              ...List.generate(10, (index) => index + 1).map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRating = e;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedRating == e
                                          ? _fillColor(selectedRating)
                                          : Colors.grey,
                                    ),
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
                            ],
                          ),
                        ),
                      ),
                      FilledButton.tonal(
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
        }).then((selectedRating) {
      if (selectedRating != null) {
        BlocProvider.of<RatingCubit>(context).rateMovie(selectedRating);
      } else {
        BlocProvider.of<RatingCubit>(context).unrateMovie();
      }
    });
  }

  Color _fillColor(selectedRating) {
    if (selectedRating == null) {
      return Colors.grey;
    } else {
      if (selectedRating > 7) {
        return Colors.green;
      } else if (selectedRating > 5) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }
  }
}
