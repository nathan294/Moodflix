class Movie {
  final int id;
  final String title;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String releaseDate;
  final int releaseYear;
  final double popularity;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.id,
    required this.title,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.releaseYear,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  // Deserialize a Movie instance from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      genreIds: List<int>.from(json['genre_ids']),
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      releaseYear: json['release_year'],
      popularity: json['popularity'].toDouble(),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  // Serialize a Movie instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre_ids': genreIds,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'release_year': releaseYear,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  Movie copyWith({
    int? id,
    String? title,
    List<int>? genreIds,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    int? releaseYear,
    double? popularity,
    double? voteAverage,
    int? voteCount,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      genreIds: genreIds ?? this.genreIds,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      releaseYear: releaseYear ?? this.releaseYear,
      popularity: popularity ?? this.popularity,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}
