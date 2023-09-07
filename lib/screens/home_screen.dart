import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/consts.dart';
import 'package:marvel_app/main.dart';
import 'package:marvel_app/providers/auth_provider.dart';
import 'package:marvel_app/providers/movies_provider.dart';
import 'package:marvel_app/widgets/custom_icons_button.dart';
import 'package:marvel_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MoviesProvider>(builder: (context, moviesConsumer, child) {
      return Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO : Here add Profile Navigation
                  },
                  child: const ListTile(
                    title: Text("My Profile"),
                    trailing: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ListTile(
                    title: Text("Contact Us"),
                    trailing: Icon(Icons.headphones),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout()
                        .then((logedout) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const ScreenRouter()),
                          (route) => false);
                    });
                  },
                  child: const ListTile(
                    title: Text("Logout"),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          centerTitle: true,
          title: Hero(
            tag: 'logo',
            child: Image.asset(
              "assets/marvel_logo.png",
              width: size.width * 0.25,
            ),
          ),
          actions: [
            CustomIconButton(
                asset: 'assets/icons/heart_outlined.png',
                color: primaryColor,
                onPressed: () {}),
            CustomIconButton(
                asset: 'assets/icons/dm.png',
                color: primaryColor,
                onPressed: () {})
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(microseconds: 300),
          child: moviesConsumer.isFailed
              ? SizedBox(
                  height: size.height * 1.1,
                  child: Center(
                    child: Text(
                      "Somthing went wrong!",
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<MoviesProvider>(context, listen: false)
                        .fetchMovies();
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: moviesConsumer.isLoading
                        ? 20
                        : moviesConsumer.movies.length,
                    itemBuilder: (context, index) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: moviesConsumer.isLoading
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: primaryColor.withOpacity(0.1))),
                                child: Shimmer.fromColors(
                                    baseColor: primaryColor,
                                    highlightColor:
                                        Colors.white.withOpacity(0.2),
                                    enabled: true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5),
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: child,
                                    )),
                              )
                            : MovieCard(
                                marvelMovieModel: moviesConsumer.movies[index],
                              ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24),
                  ),
                ),
        ),
      );
    });
  }
}
