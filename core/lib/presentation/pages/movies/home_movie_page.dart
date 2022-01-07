import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/popular_movies_cubit.dart';
import 'package:core/presentation/bloc/movies/top_rated_movies_cubit.dart';
import 'package:core/presentation/bloc/result_state.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
      context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies();
      context.read<PopularMoviesCubit>().fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMoviesCubit, ResultState<List<Movie>>>(
                builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    key: Key('now_playing_loading'),
                  ),
                );
              }

              if (state.data?.isNotEmpty == true) {
                return MovieList(state.data!);
              }

              return const Text(
                'Failed',
                key: Key('text_now_playing_error'),
              );
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, moviePopularRoute),
            ),
            BlocBuilder<PopularMoviesCubit, ResultState<List<Movie>>>(
                builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    key: Key('popular_loading'),
                  ),
                );
              }

              if (state.data?.isNotEmpty == true) {
                return MovieList(state.data!);
              }

              return const Text(
                'Failed',
                key: Key('text_popular_error'),
              );
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, movieTopRatedRoute),
            ),
            BlocBuilder<TopRatedMoviesCubit, ResultState<List<Movie>>>(
                builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    key: Key('top_rated_loading'),
                  ),
                );
              }

              if (state.data?.isNotEmpty == true) {
                return MovieList(state.data!);
              }

              return const Text(
                'Failed',
                key: Key('text_top_rated_error'),
              );
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
