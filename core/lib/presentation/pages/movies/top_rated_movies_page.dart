import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedMoviesCubit>().fetchTopRatedMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesCubit, ResultState<List<Movie>>>(
          builder: (context, state) {
            if (state.data.isEmpty) {
              return const Center(
                key: Key('empty_message'),
                child: Text('No Data'),
              );
            }

            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.data.isNotEmpty) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final movie = state.data[index];
                  return MovieCard(movie);
                },
              );
            }

            return Center(
              key: const Key('error_message'),
              child: Text(state.error ?? ''),
            );
          },
        ),
      ),
    );
  }
}
