import 'dart:convert';

class TvModel {
  int? id;
  int? vote_count;

  double? popularity;
  double? vote_average;

  bool? adult;

  String? backdrop_path;
  String? original_language;
  String? original_name;
  String? overview;
  String? poster_path;
  String? first_air_date;
  String? name;

  List<dynamic>? genre_ids;
  List<dynamic>? origin_country;
  TvModel({
    this.id,
    this.vote_count,
    this.popularity,
    this.vote_average,
    this.adult,
    this.backdrop_path,
    this.original_language,
    this.original_name,
    this.overview,
    this.poster_path,
    this.first_air_date,
    this.name,
    this.genre_ids,
    this.origin_country,
  });

  TvModel copyWith({
    int? id,
    int? vote_count,
    double? popularity,
    double? vote_average,
    bool? adult,
    String? backdrop_path,
    String? original_language,
    String? original_name,
    String? overview,
    String? poster_path,
    String? first_air_date,
    String? name,
    List<dynamic>? genre_ids,
    List<dynamic>? origin_country,
  }) {
    return TvModel(
      id: id ?? this.id,
      vote_count: vote_count ?? this.vote_count,
      popularity: popularity ?? this.popularity,
      vote_average: vote_average ?? this.vote_average,
      adult: adult ?? this.adult,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      original_language: original_language ?? this.original_language,
      original_name: original_name ?? this.original_name,
      overview: overview ?? this.overview,
      poster_path: poster_path ?? this.poster_path,
      first_air_date: first_air_date ?? this.first_air_date,
      name: name ?? this.name,
      genre_ids: genre_ids ?? this.genre_ids,
      origin_country: origin_country ?? this.origin_country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'vote_count': vote_count,
      'popularity': popularity,
      'vote_average': vote_average,
      'adult': adult,
      'backdrop_path': backdrop_path,
      'original_language': original_language,
      'original_name': original_name,
      'overview': overview,
      'poster_path': poster_path,
      'first_air_date': first_air_date,
      'name': name,
      'genre_ids': genre_ids,
      'origin_country': origin_country,
    };
  }

  factory TvModel.fromMap(Map<String, dynamic> map) {
    return TvModel(
      id: map['id'] != null ? map['id'] as int : null,
      vote_count: map['vote_count'] != null ? map['vote_count'] as int : null,
      popularity:
          map['popularity'] != null ? map['popularity'] as double : null,
      vote_average:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      adult: map['adult'] != null ? map['adult'] as bool : null,
      backdrop_path:
          map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      original_language:
          map['original_language'] != null
              ? map['original_language'] as String
              : null,
      original_name:
          map['original_name'] != null ? map['original_name'] as String : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      poster_path:
          map['poster_path'] != null ? map['poster_path'] as String : null,
      first_air_date:
          map['first_air_date'] != null
              ? map['first_air_date'] as String
              : null,
      name: map['name'] != null ? map['name'] as String : null,
      genre_ids:
          map['genre_ids'] != null
              ? List<dynamic>.from((map['genre_ids'] as List<dynamic>))
              : null,
      origin_country:
          map['origin_country'] != null
              ? List<dynamic>.from((map['origin_country'] as List<dynamic>))
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TvModel.fromJson(String source) =>
      TvModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
