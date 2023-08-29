import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/consts.dart';
import 'package:marvel_app/models/marvel_movie_model.dart';
import 'package:http/http.dart' as http ;
import 'package:marvel_app/widgets/custom_icons_button.dart';
import 'package:marvel_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MarvelMovieModel> movies = [];
 bool isLoading = false ;
fetchMovies ()async {
  setState(() {
    isLoading = true ;
  });

 final response = await  http.get(Uri.parse("https://mcuapi.herokuapp.com/api/v1/movies"));

if (kDebugMode) {
  print("STATUS CODE IS : ${response.statusCode}");
  print("RESPONSE IS : ${response.body}");

}

var decodedData = json.decode(response.body) ['data'] ;
for(var x in  decodedData ){
  movies.add(MarvelMovieModel.fromJson(x) ) ;
}
setState(() {
    isLoading = false ;
  });
}


@override
  void initState() {
    fetchMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

  
Size size = MediaQuery.of(context).size ;

    return  Scaffold(
      drawer: const Drawer(),
      
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black87),
              centerTitle: true,
              title: Image.asset("assets/marvel_logo.png" , width: size.width *0.25,), actions: [ CustomIconButton(asset: 'assets/icons/heart_outlined.png', color: primaryColor, onPressed: (){}), CustomIconButton(asset: 'assets/icons/dm.png', color: primaryColor, onPressed: (){})],),

      body: isLoading ? Center(child:  CircularProgressIndicator( color: primaryColor, ),):  GridView.builder(


        padding: const EdgeInsets.all(24),
        itemCount:  movies.length
        ,itemBuilder: (context , index){
          return  MovieCard(marvelMovieModel: movies[index],) ; },
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , childAspectRatio: 1/1.5 , mainAxisSpacing: 24 , crossAxisSpacing: 24 ),),
    );
  }
}