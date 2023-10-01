import 'package:flutter/material.dart';
import 'package:moodflix/core/widgets/shimmer_image.dart';

class MoviePosterWidget extends StatelessWidget {
  final String imageUrl;

  // Optional: Include a height parameter with a default value
  final double height;

  const MoviePosterWidget({
    Key? key,
    required this.imageUrl,
    this.height = 150.0, // Set a default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Set the height of the container
      width: height * 2 / 3, // Maintain a 2:3 aspect ratio
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: ShimmerImagePlaceholder(imageUrl: imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

// Usage in MovieTitleRowWidget:
// ...
// ...