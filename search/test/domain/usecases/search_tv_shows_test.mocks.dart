// Mocks generated by Mockito 5.0.17 from annotations
// in search/test/domain/usecases/search_tv_shows_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/core.dart' as _i5;
import 'package:core/domain/entities/tv_shows/tv_show.dart' as _i6;
import 'package:core/domain/entities/tv_shows/tv_show_detail.dart' as _i7;
import 'package:core/domain/repositories/tv_shows/tv_show_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i3.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>> getOnTheAirTvShows() =>
      (super.noSuchMethod(Invocation.method(#getOnTheAirTvShows, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvShow>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvShow>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvShow>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.TvShowDetail>>.value(
              _FakeEither_0<_i5.Failure, _i7.TvShowDetail>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i7.TvShowDetail>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvShow>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvShow>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> saveWatchlist(
          _i7.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> removeWatchlist(
          _i7.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.TvShow>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.TvShow>>>);
}
