import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MovieInfo extends StatelessWidget {
  final Movie movie;

  const MovieInfo({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.5,
          color: Colors.white12,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use min size for the column
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: const Icon(Icons.movie, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Flexible( // Use Flexible to allow the text to adjust
            child: Text(
              movie.title, // Use movie title
              overflow: TextOverflow.ellipsis, // Prevent overflow
              maxLines: 1, // Limit to one line
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Rating: ${movie.voteAverage.toStringAsFixed(1)}', // Display vote average
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
