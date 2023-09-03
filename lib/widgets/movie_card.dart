import 'package:flutter/material.dart';
import 'package:marvel_app/models/marvel_movie_model.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.marvelMovieModel});

  final MarvelMovieModel marvelMovieModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        footer: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  marvelMovieModel.duration.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  marvelMovieModel.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        child: Image.network(
          marvelMovieModel.coverUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
