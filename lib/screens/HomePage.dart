import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:possibuild/models/apiData.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:possibuild/screens/IndividualMovie.dart';
// import 'package:learn30/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

String stringResponce = "";
Map mapResponce = {};
List dataResponse = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://api-telly-tell.herokuapp.com/movies/rahul.verma";

  late VideoPlayerController videoPlayerController = VideoPlayerController.network(
      "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
  ChewieController? chewieController;

  late Future<List<MovieModel>> futureMovieModel;
  List<MovieModel> movieModel = [];
  List<RatingModel> ratingModel = [];
  List<ActorModel> actorModel = [];
  List<String> movieClip = [];
  Map<int, String> movieImg = {};
  List<List<String>> movieLang = [];
  Map<int, String> movieGenres = {};
  Map<int, String> movieEnglish = {};
  Map<int, String> movieTamil = {};
  Future<List<MovieModel>> apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    mapResponce = await json.decode(response.body);
    dataResponse = mapResponce["data"];
    int i = 0;
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

      if (!movie["video"].isEmpty) {
        String clip = movie["video"];
        movieClip.add(clip);
      }
      if (!movie['image'].isEmpty) {
        String img = movie['image'];
        movieImg[i] = img;
        if (movie['Languages'].indexOf("English") != -1) {
          movieEnglish[i] = img;
        }
        if (movie['Languages'].indexOf("Tamil") != -1) {
          movieTamil[i] = img;
        }
      }
      if (!movie['Languages'].isEmpty) {
        List<String> lang = movie['Languages'].toString().split(",");
        for (var i = 0; i < lang.length; i++) {
          lang[i] = lang[i].trim();
        }
        movieLang.add(lang);
      }
      if (!movie['genres'].isEmpty) {
        movieGenres[i] = movie['genres'];
      }

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
          languages: movie['Languages'],
          runtimeStr: movie['RuntimeStr'],
          plot: movie['Plot'],
          writers: movie['Writers'],
          title: movie['title'],
          actors: actorModel,
          banner: movie['banner']);
      movieModel.add(movieDetails);
      i += 1;
    }

    if (response.statusCode == 200) {
      return movieModel;
    } else {
      throw Exception("Failed to load data");
    }
  }

  bool isbtnPressed = false;
  bool ishoverOnCard = false;
  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(
        "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
      placeholder: Container(
        color: Colors.white,
      ),
      autoInitialize: true,
    );
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
    futureMovieModel = apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "MOVIES NOW",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.notifications),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.more_vert),
                        ],
                      )
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                child: const CupertinoSearchTextField(
                  placeholder: "Search here",
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    size: 25,
                  ),
                  padding: EdgeInsets.only(top: 15, left: 10, bottom: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: futureMovieModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return futureMovieModelData(context);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column futureMovieModelData(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: movieImg.values.toList().map((item) {
            MapEntry entry = movieImg.entries
                .firstWhere((element) => element.value == item.toString());
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        IndividualMovie(movieModel: movieModel[entry.key]),
                  ),
                );
              },
              child: Center(
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     videoPlayerController.value.isPlaying
        //         ? videoPlayerController.pause()
        //         : videoPlayerController.play();
        //   },
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     color: Colors.white,
        //     height: MediaQuery.of(context).size.height * 0.28,
        //     child: AspectRatio(
        //       aspectRatio: videoPlayerController.value.aspectRatio,
        //       child: VideoPlayer(videoPlayerController),
        //     ),
        //   ),
        // ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: GridView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 9,
                  mainAxisExtent: 290,
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
                                    : Image.network(movieModel[i]
                                        .actors![i + 3]
                                        .image
                                        .toString()),
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

        LanguageWiseMovie(
          map: movieImg,
          category: 'Top Movies',
          movieModel: movieModel,
        ),
        LanguageWiseMovie(
          map: movieEnglish,
          category: 'English Movies',
          movieModel: movieModel,
        ),
        LanguageWiseMovie(
          map: movieTamil,
          category: 'Tamil Movies',
          movieModel: movieModel,
        ),
      ],
    );
  }
}

class LanguageWiseMovie extends StatelessWidget {
  const LanguageWiseMovie({
    Key? key,
    required this.map,
    required this.category,
    required this.movieModel,
  }) : super(key: key);
  final Map<int, String> map;
  final String category;
  final List<MovieModel> movieModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 23, top: 30),
          alignment: Alignment.bottomLeft,
          child: Text(
            category.toUpperCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          height: 200,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemExtent: 150,
              itemCount: map.length,
              itemBuilder: (context, i) {
                List key = map.keys.toList();
                List value = map.values.toList();
                return (mapResponce['data'].toString() == "null")
                    ? const CircularProgressIndicator()
                    : (value[i].toString() != "")
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualMovie(
                                      movieModel: movieModel[key[i]]),
                                ),
                              );
                            },
                            child: Image.network(
                              value[i].toString(),
                            ),
                          )
                        : Container();
              }),
        ),
      ],
    );
  }
}
