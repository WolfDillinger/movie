import 'dart:convert';

class MovieModel {
  int? id;
  int? vote_count;

  double? popularity;
  double? vote_average;

  bool? adult;
  bool? video;

  String? backdrop_path;
  String? original_language;
  String? original_title;
  String? overview;
  String? poster_path;
  String? release_date;
  String? title;

  List<dynamic>? genre_ids;
  MovieModel({
    this.id,
    this.vote_count,
    this.popularity,
    this.vote_average,
    this.adult,
    this.video,
    this.backdrop_path,
    this.original_language,
    this.original_title,
    this.overview,
    this.poster_path,
    this.release_date,
    this.title,
    this.genre_ids,
  });

  MovieModel copyWith({
    int? id,
    int? vote_count,
    double? popularity,
    double? vote_average,
    bool? adult,
    bool? video,
    String? backdrop_path,
    String? original_language,
    String? original_title,
    String? overview,
    String? poster_path,
    String? release_date,
    String? title,
    List<dynamic>? genre_ids,
  }) {
    return MovieModel(
      id: id ?? this.id,
      vote_count: vote_count ?? this.vote_count,
      popularity: popularity ?? this.popularity,
      vote_average: vote_average ?? this.vote_average,
      adult: adult ?? this.adult,
      video: video ?? this.video,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      original_language: original_language ?? this.original_language,
      original_title: original_title ?? this.original_title,
      overview: overview ?? this.overview,
      poster_path: poster_path ?? this.poster_path,
      release_date: release_date ?? this.release_date,
      title: title ?? this.title,
      genre_ids: genre_ids ?? this.genre_ids,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vote_count': vote_count,
      'popularity': popularity,
      'vote_average': vote_average,
      'adult': adult,
      'video': video,
      'backdrop_path': backdrop_path,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'poster_path': poster_path,
      'release_date': release_date,
      'title': title,
      'genre_ids': genre_ids,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] != null ? map['id'] as int : null,
      vote_count: map['vote_count'] != null ? map['vote_count'] as int : null,
      popularity:
          map['popularity'] != null ? map['popularity'] as double : null,
      vote_average:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      adult: map['adult'] != null ? map['adult'] as bool : null,
      video: map['video'] != null ? map['video'] as bool : null,
      backdrop_path:
          map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      original_language:
          map['original_language'] != null
              ? map['original_language'] as String
              : null,
      original_title:
          map['original_title'] != null
              ? map['original_title'] as String
              : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      poster_path:
          map['poster_path'] != null ? map['poster_path'] as String : null,
      release_date:
          map['release_date'] != null ? map['release_date'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      genre_ids:
          map['genre_ids'] != null
              ? List<dynamic>.from((map['genre_ids'] as List<dynamic>))
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
