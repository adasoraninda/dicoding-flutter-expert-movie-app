import 'package:core/data/datasources/tv_shows/tv_show_local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvShow(tTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(tTvShowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistTvShow(tTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(tTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(tTvShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(tTvShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvShow(tTvShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(tTvShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Show Detail By Id', () {
    const tId = 1;

    test('should return Tv Show Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId))
          .thenAnswer((_) async => tTvShowTableMap);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, tTvShowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tv Shows', () {
    test('should return list of TvShowTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvShows())
          .thenAnswer((_) async => [tTvShowTableMap]);
      // act
      final result = await dataSource.getWatchlistTvShows();
      // assert
      expect(result, [tTvShowTable]);
    });
  });
}
