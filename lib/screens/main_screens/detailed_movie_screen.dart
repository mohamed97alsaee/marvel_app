import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/helper_functions.dart';
import 'package:marvel_app/models/marvel_movie_model.dart';
import 'package:marvel_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class DetailedMovieScreen extends StatefulWidget {
  const DetailedMovieScreen({super.key, required this.marvelMovieModel});
  final MarvelMovieModel marvelMovieModel;
  @override
  State<DetailedMovieScreen> createState() => _DetailedMovieScreenState();
}

class _DetailedMovieScreenState extends State<DetailedMovieScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false)
        .fetchDetailedMovie(widget.marvelMovieModel.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (context, moviesConsumer, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: moviesConsumer.isLoading
            ? null
            : AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                title: Text(
                  moviesConsumer.currentMovie!.title.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
        body: Center(
          child: moviesConsumer.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Divider(
                            color: Colors.red.withOpacity(0.3),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.network(
                                      moviesConsumer.currentMovie!.coverUrl)),
                            ),
                            const Positioned(
                              top: 50,
                              right: 50,
                              child: Padding(
                                padding: EdgeInsets.all(34.0),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/video-play.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(moviesConsumer.currentMovie!.directedBy
                                .toString())
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/clock.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(fromIntToDuration(
                                moviesConsumer.currentMovie!.duration))
                          ],
                        ),
                        if (moviesConsumer.currentMovie!.overview != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Text(moviesConsumer.currentMovie!.overview
                                  .toString()),
                            ],
                          ),
                        if (moviesConsumer.currentMovie!.trailerUrl != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                  onPressed: () {}, child: Text('TRAILER')),
                            ],
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
