import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movies/movie.dart';
import 'package:core/presentation/bloc/movies/movie_list_cubit.dart';
import 'package:core/presentation/bloc/tri_result_list_state.dart';
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
    Future.microtask(
      () => context.read<MovieListCubit>()
        ..fetchNowPlayingMovies()
        ..fetchTopRatedMovies()
        ..fetchPopularMovies(),
    );
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
            BlocBuilder<MovieListCubit, TriResultListState<Movie>>(
                builder: (context, state) {
              if (state.nowLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.nowData.isNotEmpty) {
                return MovieList(state.nowData);
              }

              return const Text('Failed');
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, moviePopularRoute),
            ),
            BlocBuilder<MovieListCubit, TriResultListState<Movie>>(
                builder: (context, state) {
              if (state.popularLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.popularData.isNotEmpty) {
                return MovieList(state.popularData);
              }

              return const Text('Failed');
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, movieTopRatedRoute),
            ),
            BlocBuilder<MovieListCubit, TriResultListState<Movie>>(
                builder: (context, state) {
              if (state.topLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.topData.isNotEmpty) {
                return MovieList(state.topData);
              }

              return const Text('Failed');
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
