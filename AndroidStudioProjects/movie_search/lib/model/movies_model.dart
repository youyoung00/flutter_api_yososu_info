class MovieModel {
  final String posterPath;
  final String backdropPath;
  final String title;
  final String overview;
  final int voteCount;
  final double voteAverage;
  final String releaseDate;

  MovieModel({
    required this.posterPath,
    required this.backdropPath,
    required this.title,
    required this.overview,
    required this.voteCount,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      posterPath: json['poster_path'],
      backdropPath: json['backdropPath'],
      title: json['title'],
      overview: json['overview'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'],
      releaseDate: json['release_date'],
    );
  }

  static List<MovieModel> listToMoves(List jsonList) {
    return jsonList.map((e) => MovieModel.fromJson(e)).toList();
  }
}
