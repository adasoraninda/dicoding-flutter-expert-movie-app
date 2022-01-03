import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/tv_shows/tv_show_detail_model.dart';
import 'package:core/data/models/tv_shows/tv_show_model.dart';
import 'package:core/data/models/tv_shows/tv_show_response.dart';
import 'package:http/http.dart' as http;

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getOnTheAirTvShows();

  Future<List<TvShowModel>> getPopularTvShows();

  Future<List<TvShowModel>> getTopRatedTvShows();

  Future<TvShowDetailResponse> getTvShowDetail(int id);

  Future<List<TvShowModel>> getTvShowRecommendations(int id);

  Future<List<TvShowModel>> searchTvShows(String query);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvShowModel>> getOnTheAirTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
  }

  @override
  Future<TvShowDetailResponse> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TvShowDetailResponse.fromJson(json.decode(response.body));
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode != 200) {
      throw ServerException();
    }

    return TvShowResponse.fromJson(json.decode(response.body)).tvShowList;
  }
}
