import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/models/marvel_movie_model.dart';
import 'package:marvel_app/screens/main_screens/detailed_movie_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.marvelMovieModel});

  final MarvelMovieModel marvelMovieModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => DetailedMovieScreen(
                      marvelMovieModel: marvelMovieModel,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            GridTile(
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
            const Positioned(
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
