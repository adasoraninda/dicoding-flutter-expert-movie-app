import 'package:ditonton/data/datasources/tv_shows/tv_show_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get on the air tv shows', () {});

  group('get popular tv shows', () {});

  group('get top rated tv shows', () {});

  group('get tv show detail', () {});

  group('get tv show recommendations', () {});
  group('search tv shows', () {});
}
