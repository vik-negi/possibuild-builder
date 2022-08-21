import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:possibuild/models/apiData.dart';
import 'package:possibuild/screens/IndividualMovie.dart';
import 'package:video_player/video_player.dart';

String stringResponce = "";
Map mapResponce = {};
List dataResponse = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController videoPlayerController = VideoPlayerController.network(
      "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
  ChewieController? chewieController;

  String url = "https://api-telly-tell.herokuapp.com/movies/rahul.verma";

  List<MovieModel> movieModel = [];
  List<RatingModel> ratingModel = [];
  List<ActorModel> actorModel = [];
  List<String> movieClip = [];
  List<String> movieImg = [];
  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    mapResponce = json.decode(response.body);
    dataResponse = mapResponce["data"];

    for (var movie in dataResponse) {
      // if (!movie['banner'].isEmpty && movie['banner'] != "") {
      //   movieImg.add(movie['banner']);
      //   print(movie['banner']);
      // } else {
      //   movieImg.add(
      //       "https://res.cloudinary.com/duenuiiav/image/upload/v1649921443/video%20Banners/x4ima2idjbgvv3d4mesp.jpg");
      // }
      if (!movie["Ratings"].isEmpty) {
        RatingModel rating = RatingModel(
          imDb: movie["imDb"],
          metacritic: movie['metacritic'],
          theMovieDb: movie['theMovieDb'],
          rottenTomatoes: movie['rottenTomatoes'],
          filmAffinity: movie['filmAffinity'],
        );
        ratingModel.add(rating);
      }
      if (!movie["video"].isEmpty) {
        String clip = movie["video"];
        movieClip.add(clip);
        print(clip);
      }
      if (!movie['image'].isEmpty) {
        String img = movie['image'];
        movieImg.add(img);
        print(img);
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

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(
        "https://res.cloudinary.com/duenuiiav/video/upload/v1649789401/videos/keywcjty6xusjvtumpjt.mp4");
    await Future.wait([videoPlayerController.initialize()]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      placeholder: Container(
        color: Colors.greenAccent,
      ),
      autoInitialize: true,
    );
  }

  bool isbtnPressed = false;
  bool ishoverOnCard = false;

  @override
  void initState() {
    // initializePlayer();
    super.initState();
    apiCall();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // videoPlayerController.dispose();
    chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.28,
              child: AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
            CarouselSlider(
              items: movieImg
                  .map((item) => Container(
                        child: Center(
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            // videoPlayerController.value.isInitialized
            //     ?

            // : Container(),
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
            Text(movieImg.toString()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: GridView.builder(
                  physics: ClampingScrollPhysics(),
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
                                  builder: (context) => IndividualMovie(
                                      movieModel: movieModel[i]),
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
      ),
    );
  }
}
