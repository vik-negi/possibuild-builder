import 'package:flutter/cupertino.dart';
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
  late String showenString =
      widget.movieModel.plot.toString().substring(0, 150);
  late String hidenString = "";
  // widget.movieModel.plot.toString().substring(150, widget.movieModel.plot.toString().length);

  bool isShowMore = false;

  @override
  void initState() {
    super.initState();
    String moviePlot = widget.movieModel.plot.toString();
    if (moviePlot.length > 150) {
      showenString = moviePlot.substring(0, 150);
      hidenString = moviePlot.substring(150, moviePlot.length);
    } else {
      showenString = moviePlot;
      hidenString = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    MovieModel movie = widget.movieModel;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network((movie.banner != null)
                  ? movie.banner.toString()
                  : "https://qph.cf2.quoracdn.net/main-qimg-a1444ec6410b4d33f33ed6aa6b4a04a5-lq"),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        movie.title.toString().toUpperCase(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.hand_thumbsup_fill,
                                size: 30,
                              ),
                            ),
                            const Text("Likes"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                size: 30,
                              ),
                            ),
                            const Text("Share"),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              ),
                            ),
                            const Text("Add Playlist"),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      height: 2,
                      color: Colors.grey,
                    ),
                    hidenString.isEmpty
                        ? Text(showenString)
                        : Stack(
                            children: [
                              Text(
                                isShowMore
                                    ? ("$showenString...")
                                    : (showenString + hidenString),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShowMore = !isShowMore;
                                    });
                                  },
                                  child: Text(
                                    isShowMore ? "show more" : "show less",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
