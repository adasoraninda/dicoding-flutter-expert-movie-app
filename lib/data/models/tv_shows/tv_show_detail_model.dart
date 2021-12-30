import 'package:ditonton/domain/entities/tv_shows/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

import '../genre_model.dart';

class TvShowDetailResponse extends Equatable {
  TvShowDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.episodeRunTime,
    required this.status,
    required this.tagline,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String firstAirDate;
  final int episodeRunTime;
  final String status;
  final String tagline;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory TvShowDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvShowDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalLanguage:
            _formatDataStringNull(json["original_language"].toString()),
        originalName: _formatDataStringNull(json["original_name"]),
        overview: _formatDataStringNull(json['overview']),
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: _formatDataStringNull(json["first_air_date"]),
        episodeRunTime:
            _formatAirDate(List<int?>.from(json["episode_run_time"])),
        status: _formatDataStringNull(json["status"]),
        tagline: _formatDataStringNull(json["tagline"]),
        name: _formatDataStringNull(json["name"]),
        voteAverage: json["vote_average"].toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  static String _formatDataStringNull(String? data) {
    return data == null || data.isEmpty ? '-' : data;
  }

  static int _formatAirDate(List<int?> datas) {
    if (datas.isEmpty) return 0;
    return datas[0] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "episode_run_time": [episodeRunTime],
        "status": status,
        "tagline": tagline,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvShowDetail toEntity() {
    return TvShowDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      episodeRunTime: this.episodeRunTime,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        homepage,
        id,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        episodeRunTime,
        status,
        tagline,
        name,
        voteAverage,
        voteCount,
      ];
}
