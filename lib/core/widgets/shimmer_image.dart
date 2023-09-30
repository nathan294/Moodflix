import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImagePlaceholder extends StatelessWidget {
  final String imageUrl;

  const ShimmerImagePlaceholder({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(NetworkImage(imageUrl), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(imageUrl, fit: BoxFit.cover);
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.grey[300],
            ),
          );
        }
      },
    );
  }
}
