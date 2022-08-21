import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:possibuild/models/apiData.dart';
import 'package:possibuild/screens/IndividualMovie.dart';

String stringResponce = "";
Map mapResponce = {};
List dataResponse = [];
List<String> movieClip = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://api-telly-tell.herokuapp.com/movies/rahul.verma";

  List<MovieModel> movieModel = [];
  List<RatingModel> ratingModel = [];
  List<ActorModel> actorModel = [];
  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    mapResponce = json.decode(response.body);
    dataResponse = mapResponce["data"];

    for (var movie in dataResponse) {
      if (!movie["Ratings"].isEmpty) {
        RatingModel rating = RatingModel(
            imDb: movie["imDb"],
            metacritic: movie['metacritic'],
            theMovieDb: movie['theMovieDb'],
            rottenTomatoes: movie['rottenTomatoes'],
            filmAffinity: movie['filmAffinity']);

        ratingModel.add(rating);
      }
      String clip = movie["video"];
      movieClip.add(clip);
      print(clip);

      if (!movie["Actors_list"].isEmpty) {
        for (var actor in movie["Actors_list"]) {
          ActorModel actorDetails = ActorModel(
            name: actor['name'],
            asCharacter: actor['asCharacter'],
            image: actor['image'],
          );
          actorModel.add(actorDetails);
        }
      }

      MovieModel movieDetails = MovieModel(
          ratings: ratingModel,
          description: movie['description'],
          live: movie['live'],
          thumbnail: movie["thumbnail"],
          launchDate: movie['launchDate'],
          video: movie['video'],
          directors: movie['directors'],
          year: movie['year'],
          image: movie['image'],
          genres: movie['genres'],
          languages: movie['languages'],
          runtimeStr: movie['runtimeStr'],
          plot: movie['plot'],
          writers: movie['writers'],
          title: movie['title'],
          actors: actorModel,
          banner: movie['banner']);
      movieModel.add(movieDetails);
    }
    // print(movieModel);
    return movieModel;
  }

  bool isbtnPressed = false;
  bool ishoverOnCard = false;

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Column(
        children: [
          // AutoPlayList(
          //   itemCount: movieModel.length,
          //   itemExtent: 400,
          //   itemBuilder: (context, i) {
          //     return Container(
          //       padding: EdgeInsets.all(1),
          //       child: AutoPlayVideo(
          //         index: i,
          //         network: movieModel[i].video.toString(),
          //       ),
          //     );
          //   },
          // ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 9,
                    mainAxisExtent: 280,
                    crossAxisSpacing: 6,
                    crossAxisCount:
                        (Orientation == Orientation.portrait) ? 3 : 2),
                itemCount: movieModel.length,
                itemBuilder: (context, i) {
                  return (mapResponce['data'].toString() == "null")
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IndividualMovie(movieModel: movieModel[i]),
                              ),
                            );
                          },
                          onLongPress: () {
                            setState(() {
                              ishoverOnCard = true;
                              print("jii");
                            });
                          },
                          child: Card(
                            child: Container(
                              // width: MediaQuery.of(context).size.width * 0.38,
                              // height: 350,
                              child: Column(
                                children: [
                                  (movieModel[i].image.toString() != "")
                                      ? Image.network(
                                          movieModel[i].image.toString(),
                                          // width: 210,
                                          opacity: ishoverOnCard
                                              ? const AlwaysStoppedAnimation<
                                                  double>(0.5)
                                              : const AlwaysStoppedAnimation<
                                                  double>(1),
                                          height: 245,
                                        )
                                      : Container(),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              movieModel[i].title.toString(),
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
                }),
          ),
        ],
      ),
    );
  }
}
