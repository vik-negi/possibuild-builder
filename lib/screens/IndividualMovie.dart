import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:possibuild/models/apiData.dart';

class IndividualMovie extends StatefulWidget {
  const IndividualMovie({
    Key? key,
    required this.movieModel,
    required this.idx,
  }) : super(key: key);
  final MovieModel movieModel;
  final int idx;

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

  late List value = [];

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
                    const SizedBox(
                      height: 8,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
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
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            movieDetails(
                                title: "Director : ",
                                reply: movie.directors.toString()),
                            movieDetails(
                                title: "Released on : ",
                                reply: movie.launchDate
                                    .toString()
                                    .substring(0, 10)),
                            movieDetails(
                                title: "Languages : ",
                                reply: movie.languages.toString()),
                            movieDetails(
                                title: "Writred : ",
                                reply: movie.writers.toString()),
                            movieDetails(
                              title: "Year : ",
                              reply: movie.year.toString(),
                            ),
                            const movieDetails(
                              title: "Type : ",
                              reply: "Movie",
                            ),
                            // Text(
                            //     "Released on : ${movie.launchDate.toString()}"),
                            // Text("Director : ${movie.writers.toString()}"),
                            // Text("Director : ${movie.year.toString()}"),
                          ],
                        )),
                    Text(movie.description.toString()),
                    (widget.idx != 6 || widget.idx != 7)
                        ? Container(
                            padding: const EdgeInsets.only(left: 23, top: 30),
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              "Actors",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          )
                        : Container(),
                    (widget.idx != 6 && widget.idx != 7)
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            height: 250,
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemExtent: 102,
                                itemCount: 17,
                                itemBuilder: (context, i) {
                                  List value = [];
                                  for (var j = 0;
                                      j < movie.actors!.length;
                                      j++) {
                                    if (movie.actors![j][0] == widget.idx) {
                                      value.add(movie.actors![j][1]);
                                    }
                                  }
                                  List characher = value[i]
                                      .asCharacter
                                      .toString()
                                      .split(" ");
                                  return (movie.actors![i].toString() != "")
                                      ? Column(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Image.network(
                                                value[i].image.toString(),
                                                width: 120,
                                                height: 90,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            InkWell(
                                              child: Text(
                                                value[i].name.toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            InkWell(
                                              child: Text(
                                                "${characher[0]} ${characher[1]}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            // ),
                                          ],
                                        )
                                      : Container();
                                }),
                          )
                        : Container(),
                  ],
                ),
              ),
              // Text(widget.idx.toString())
            ],
          ),
        ),
      ),
    );
  }
}

class movieDetails extends StatelessWidget {
  const movieDetails({Key? key, required this.title, required this.reply})
      : super(key: key);
  final String title;
  final String reply;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
          text: title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: reply,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ]),
    );
  }
}
