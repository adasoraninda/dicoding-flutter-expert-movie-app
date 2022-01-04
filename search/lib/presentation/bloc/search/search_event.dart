import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class OnQuerySubmit extends SearchEvent {
  final String query;

  const OnQuerySubmit(this.query);

  @override
  List<Object> get props => [query];
}

class SearchMovieTypeEvent extends SearchEvent {}

class SearchTvShowTypeEvent extends SearchEvent {}

