import 'package:flutter/material.dart';
import 'package:possibuild/models/apiData.dart';

class IndividualMovie extends StatefulWidget {
  const IndividualMovie({
    Key? key,
    required this.movieModel,
  }) : super(key: key);
  final MovieModel movieModel;

  @override
  State<IndividualMovie> createState() => _IndividualMovieState();
}

class _IndividualMovieState extends State<IndividualMovie> {
  @override
  Widget build(BuildContext context) {
    MovieModel movie = widget.movieModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title.toString()),
      ),
      body: Column(
        children: [
          Image.network((movie.banner != null)
              ? movie.banner.toString()
              : "https://qph.cf2.quoracdn.net/main-qimg-a1444ec6410b4d33f33ed6aa6b4a04a5-lq"),
        ],
      ),
    );
  }
}
