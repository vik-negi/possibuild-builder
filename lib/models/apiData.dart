class MovieModel {
  List<RatingModel>? ratings;
  String? description;
  bool? live;
  String? thumbnail;
  String? launchDate;
  String? video;
  String? directors;
  String? year;
  String? image;
  String? genres;
  String? languages;
  String? runtimeStr;
  String? plot;
  String? writers;
  String? title;
  List<ActorModel>? actors;
  String? banner;
  MovieModel({
    this.ratings,
    this.description,
    this.live,
    this.thumbnail,
    this.launchDate,
    this.video,
    this.directors,
    this.year,
    required this.image,
    this.genres,
    this.languages,
    this.runtimeStr,
    this.plot,
    this.writers,
    required this.title,
    this.actors,
    this.banner,
  });
}

class RatingModel {
  String? imDb;
  String? metacritic;
  String? theMovieDb;
  String? rottenTomatoes;
  String? filmAffinity;
  RatingModel({
    this.imDb,
    this.metacritic,
    this.theMovieDb,
    this.rottenTomatoes,
    this.filmAffinity,
  });
}

class ActorModel {
  String? name;
  String? asCharacter;
  String? image;
  ActorModel({
    this.name,
    this.asCharacter,
    this.image,
  });
}
