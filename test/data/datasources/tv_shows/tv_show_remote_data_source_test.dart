import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_shows/tv_show_remote_data_source.dart';
import 'package:ditonton/data/models/tv_shows/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_shows/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get on the air tv shows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_on_the_air.json')))
        .tvShowList;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_show_on_the_air.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );
      // act
      final result = await dataSource.getOnTheAirTvShows();
      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final call = dataSource.getOnTheAirTvShows();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv shows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_popular.json')))
        .tvShowList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/popular?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_show_popular.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final result = await dataSource.getPopularTvShows();

      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/popular?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final call = dataSource.getPopularTvShows();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv shows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_top_rated.json')))
        .tvShowList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_show_top_rated.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final result = await dataSource.getTopRatedTvShows();

      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final call = dataSource.getTopRatedTvShows();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    final tId = 1;
    final tTvShowDetail = TvShowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_detail.json')));

    test('should return tv show detail when response is success (200)',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$tId?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_show_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final result = await dataSource.getTvShowDetail(tId);

      // assert
      expect(result, equals(tTvShowDetail));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$tId?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final call = dataSource.getTvShowDetail(tId);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final tId = 1;
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_recommendations.json')))
        .tvShowList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_show_recommendations.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final result = await dataSource.getTvShowRecommendations(tId);

      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final call = dataSource.getTvShowRecommendations(tId);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    final tQuery = 'Naruto';
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_search.json')))
        .tvShowList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_show_search.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final result = await dataSource.searchTvShows(tQuery);

      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // assert
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
      );

      // act
      final call = dataSource.searchTvShows(tQuery);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
